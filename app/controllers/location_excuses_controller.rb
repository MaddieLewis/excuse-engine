class LocationExcusesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new show create]
  before_action :set_location_excuse, only: :show

  TFL_APP_ID = ENV['TFL_APP_ID']
  TFL_APP_KEY = ENV['TFL_APP_KEY']
  TRA_APP_CODE = ENV['TRA_APP_CODE']
  TRA_APP_ID = ENV['TRA_APP_ID']

  def new
    @location_excuse = LocationExcuse.new
  end

  def create
    @location_excuse = LocationExcuse.create(location_excuse_params)
    traffic = find_tra_excuses
    tfl = find_excuses('') + find_excuses('bus') + find_excuses('bus,tube')
    tfl.reject!{ |excuse| excuse == {} }
    traffic_excuses= traffic.map { |excuse| new_loop(excuse) }
    tfl_excuses = tfl.uniq.map { |excuse| new_loop(excuse) }
    all_excuses = tfl_excuses + traffic_excuses
    unless all_excuses.empty?
      all_excuses.map do |excuse|
        unless excuse&.lines_disrupted.nil? || excuse&.disruption_message.nil?
          unless excuse.save
            render :new
          end
        end
      end
    end
    raise
    if !all_excuses.first.nil?
      @location_excuse = all_excuses.first
      redirect_to location_excuse_path(@location_excuse)
    else
      render :new
    end
  end

  def show
  end

  private

  def location_excuse_params
    params.require(:location_excuse).permit(:start_point, :end_point)
  end

  def set_location_excuse
    @location_excuse = LocationExcuse.find(params[:id])
  end

  def api_call(mode)
    # geocode_endpoints()

    start = "#{@location_excuse.start_latitude}%2C#{@location_excuse.start_longitude}"
    end_pt = "#{@location_excuse.end_latitude}%2C#{@location_excuse.end_longitude}"
    # start = @location_excuse.start_point
    # end_pt = @location_excuse.end_point
    response = HTTP.get("https://api-radon.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?&mode=#{mode}&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")
    JSON.parse(response)
  end

  def tra_api_call
    user_start_point = "#{@location_excuse.start_latitude},#{@location_excuse.start_longitude}"
    user_end_point = "#{@location_excuse.end_latitude},#{@location_excuse.end_longitude}"
    # user_start_point = @location_excuse.start_point
    # user_end_point = @location_excuse.end_point
    response = HTTP.get("https://traffic.api.here.com/traffic/6.3/incidents.json?app_id=#{TRA_APP_ID}&app_code=#{TRA_APP_CODE}&bbox=#{user_start_point};#{user_end_point}")
    JSON.parse(response)
  end

  def find_tra_excuses
    parsed = tra_api_call
    arr = []
    traffic_items = parsed["TRAFFIC_ITEMS"]["TRAFFIC_ITEM"]
    traffic = traffic_items.select do |traffic_item|
      criticality = traffic_item['CRITICALITY']['DESCRIPTION']
      criticality == "critical" || criticality == "major"
    end
    traffic.first(5).each do |traffic_item|
      hash = {}
      e_area = traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').first
      e_area == "Past " ? e_area = traffic_item['LOCATION']['INTERSECTION']['ORIGIN']['STREET1']['ADDRESS1'] : e_area
      e_comments = traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').last
      e_start_date = traffic_item['START_TIME']
      r_origin_lat = traffic_item['LOCATION']['GEOLOC']['ORIGIN']['LATITUDE']
      r_origin_long = traffic_item['LOCATION']['GEOLOC']['ORIGIN']['LONGITUDE']
      r_to_lat = traffic_item['LOCATION']['GEOLOC']['TO'][0]['LATITUDE']
      r_to_long = traffic_item['LOCATION']['GEOLOC']['TO'][0]['LONGITUDE']
      e_message = "Traffic Alert!\n#{e_area}\nReason: #{e_comments}\nReported at: #{e_start_date}"
      hash["line"] = "#{e_area}"
      hash["message"] = "#{e_message}"
      hash["journey"] = []
      hash["journey route"] = [[r_origin_lat,r_origin_long],[r_to_lat,r_to_long]]
      arr << hash
    end
    arr
  end

  def find_excuses(mode)
    parsed = api_call(mode)
    arr = []
    parsed["lines"].each do |line|
      line["lineStatuses"].each do |line_status|
        hash = {}
        if !line_status["lineId"].nil?
          hash["line"] = line_status["lineId"]
          hash["message"] = line_status["reason"]
          all_journeys = find_all_journeys(mode)
          all_journeys.detect do |journey|
            journey.join.downcase.include?(line_status["lineId"])
            hash["journey"] = journey
            hash["journey route"] = find_journey_route(mode, journey)
          end
        end
        arr << hash
      end
    end
    arr.uniq
  end

  def find_journey_route(mode, journey)
    parsed = api_call(mode)
    journeys = parsed["journeys"]
    path = []
    journeys.each_with_index do |journ, index|
      if index == journey.first.last.to_i - 1
        journ["legs"].each do |leg|
          path << leg["path"]["lineString"]
        end
      end
    end
    path
  end

  def find_all_journeys(mode)
    parsed = api_call(mode)
    arr = []
    parsed["journeys"].each_with_index do |journey, index|
      journ = ["Journey #{index + 1}"]
      journ << "#{journey["duration"]}"
      journey["legs"].each_with_index do |leg, index|
        if leg["disruptions"].empty?
          journ << "leg #{index + 1}: #{leg["instruction"]["summary"]}"
        else
          leg["disruptions"].each do |disruption|
            if disruption["category"] == "PlannedWork" then journ << "leg #{index + 1}: #{leg["instruction"]["summary"]}"
            else
              journ << "leg #{index + 1}: #{leg["instruction"]["summary"]}, disruption: #{disruption["description"]}"
            end
          end
        end
      end
      arr << journ
    end
    arr.uniq
  end

  def new_loop(excuse)
    start = @location_excuse.start_point
    end_pt = @location_excuse.end_point
    unless excuse.nil? || excuse.empty?
      LocationExcuse.new(start_point: start, end_point: end_pt, lines_disrupted: excuse["line"], disruption_message: excuse["message"], journeys: excuse["journey"], journey_route: excuse["journey route"])
    end
  end
end
