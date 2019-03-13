class LocationExcusesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new show create details]
  before_action :set_location_excuse, only: :show

  TFL_APP_ID = ENV['TFL_APP_ID']
  TFL_APP_KEY = ENV['TFL_APP_KEY']
  TRA_APP_CODE = ENV['TRA_APP_CODE']
  TRA_APP_ID = ENV['TRA_APP_ID']
  GM_API_KEY = ENV['GM_API_KEY']

  def new
    @location_excuse = LocationExcuse.new
  end

  def create
    @location_excuse = LocationExcuse.create(location_excuse_params)
    traffic = find_tra_excuses
    tfl = find_excuses('') + find_excuses('bus') + find_excuses('bus,tube')
    tfl.reject! { |excuse| excuse == {} }
    # gmaps = find_gmaps.map { |excuse| new_loop(excuse) }
    traffic_excuses = traffic.map { |excuse| new_loop(excuse) }
    tfl_excuses = tfl.uniq.map { |excuse| new_loop(excuse) }
    all_excuses = tfl_excuses + traffic_excuses
    unless all_excuses.empty?
      all_excuses.map do |excuse|
        unless excuse.lines_disrupted.nil? || excuse.disruption_message.nil?
          render :new unless excuse.save
        end
      end
    end

    if !all_excuses.first.nil?
      @location_excuse = all_excuses.first
      redirect_to location_excuse_path(@location_excuse)
    else
      redirect_to pages_no_excuse_path
    end
  end

  def show
    @last_excuse = LocationExcuse.last
  end

  def details
    @location_excuse = LocationExcuse.find(params[:location_excuse_id])
    if @location_excuse == LocationExcuse.last
      @next_excuse = nil
    else
      @next_excuse = LocationExcuse.find(@location_excuse.id + 1)
    end
    @markers = [
      {
        lat: @location_excuse.start_latitude,
        lng: @location_excuse.start_longitude,
        infoWindow: { content: render_to_string(partial: "/location_excuses/map_box", locals: { location_excuse: @location_excuse }) }
      },
      {
        lat: @location_excuse.end_latitude,
        lng: @location_excuse.end_longitude,
        infoWindow: { content: render_to_string(partial: "/location_excuses/map_box", locals: { location_excuse: @location_excuse }) }
      }
    ]
  end

  # def gmaps
  #   @location_excuse = LocationExcuse.find(params[:location_excuse_id])
  #   @markers = [
  #     {
  #       lat: @location_excuse.start_latitude,
  #       lng: @location_excuse.start_longitude,
  #       infoWindow: { content: render_to_string(partial: "/location_excuses/map_box", locals: { location_excuse: @location_excuse }) }
  #     },
  #     {
  #       lat: @location_excuse.end_latitude,
  #       lng: @location_excuse.end_longitude,
  #       infoWindow: { content: render_to_string(partial: "/location_excuses/map_box", locals: { location_excuse: @location_excuse }) }
  #     }
  #   ]
  # end

  private

  def location_excuse_params
    params.require(:location_excuse).permit(:start_point, :end_point)
  end

  def set_location_excuse
    @location_excuse = LocationExcuse.find(params[:id])
  end

  def gm_api_call
    start = "#{@location_excuse.start_latitude}%2C#{@location_excuse.start_longitude}"
    end_pt = "#{@location_excuse.end_latitude}%2C#{@location_excuse.end_longitude}"
    url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{start}&destination=#{end_pt}&departure_time=now&traffic_model=pessimistic&key=#{GM_API_KEY}"
    response = HTTP.get(url)
    JSON.parse(response)
  end

  def api_call(mode)
    start = "#{@location_excuse.start_latitude}%2C#{@location_excuse.start_longitude}"
    end_pt = "#{@location_excuse.end_latitude}%2C#{@location_excuse.end_longitude}"
    response = HTTP.get("https://api.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?&mode=#{mode}&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")
    JSON&.parse(response)
  end

  def tra_api_call
    user_start_point = "#{@location_excuse.start_latitude},#{@location_excuse.start_longitude}"
    user_end_point = "#{@location_excuse.end_latitude},#{@location_excuse.end_longitude}"
    response = HTTP.get("https://traffic.api.here.com/traffic/6.3/incidents.json?app_id=#{TRA_APP_ID}&app_code=#{TRA_APP_CODE}&bbox=#{user_start_point};#{user_end_point}&maxresults=5&sort=criticalitydesc")
    JSON.parse(response)
  end

  def find_gmaps
    arr = []
    response = gm_api_call
    return arr if response["routes"].nil?

    response['routes'].each do |route|
      journ = []
      hash = {}
      journey_route = []
      route['legs'].each_with_index do |leg, index|
        journ << index
        journ << leg['duration_in_traffic']['text']
        leg['steps'].each do |step|
          journ << step['html_instructions']
          journey_route << step['polyline']['points']
        end
      end
      hash["journey"] = journ
      hash["journey route"] = journey_route
      hash["line"] = "Driving"
      hash["message"] = "Traffic on the route"
      arr << hash
    end
    arr.uniq
  end

  def find_tra_excuses
    parsed = tra_api_call
    return [] if parsed["TRAFFIC_ITEMS"].nil?

    arr = []
    traffic_items = parsed["TRAFFIC_ITEMS"]["TRAFFIC_ITEM"]

    traffic_items.each do |traffic_item|
      e_area = traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').first
      e_area == "Past " ? e_area = traffic_item['LOCATION']['INTERSECTION']['ORIGIN']['STREET1']['ADDRESS1'] : e_area
      e_comments = traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').last
      geo = traffic_item['LOCATION']['GEOLOC']
      e_start_date = traffic_item['START_TIME']
      r_origin_lat = geo['ORIGIN']['LATITUDE']
      r_origin_long = geo['ORIGIN']['LONGITUDE']
      r_to_lat = geo['TO'][0]['LATITUDE']
      r_to_long = geo['TO'][0]['LONGITUDE']
      c_array = []
      e_message = "Traffic Alert!\n#{e_area}\nReason: #{e_comments}\nReported at: #{e_start_date}"
      if geo['GEOMETRY'].nil?
        c_array << [[r_origin_lat, r_origin_long], [r_to_lat, r_to_long]]
      else
        geo['GEOMETRY']['SHAPES']['SHP'].each do |line|
          all = line['value'].split(' ').map { |e| e.split(',') }
          c_array << all.uniq
        end
      end
      hash = { "line" => "#{e_area}", "message" => "#{e_message}", "journey" => [], "journey route" => c_array.flatten(1), "transport_mode" => "road" }
      arr << hash
    end
    arr.uniq
  end

  def find_excuses(mode)
    parsed = api_call(mode)
    arr = []
    return arr if parsed["type"] == "Tfl.Api.Presentation.Entities.JourneyPlanner.DisambiguationResult" || parsed["lines"].nil?

    parsed["lines"].each do |line|
      line["lineStatuses"].each do |line_status|
        hash = {}
        if !line_status["lineId"].nil?
          hash["line"] = line_status["lineId"]
          hash["message"] = line_status["reason"]
          if /([A-Z]|\d)\d*/.match?(line_status["lineId"])
            hash["transport_mode"] = 'bus'
          else
            hash["transport_mode"] = 'tube'
          end
          all_journeys = find_all_journeys(mode)
          all_journeys.detect do |journey|
            if journey.join.downcase.include?(line_status["lineId"].downcase.gsub(/-/, ' '))
              hash["journey"] = journey.uniq
              hash["journey route"] = find_journey_route(mode, journey)
            end
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
          journ << leg["instruction"]["summary"].gsub(/[\n]/, '').to_s
        else
          leg["disruptions"].each do |disruption|
            if disruption["category"] == "PlannedWork" then journ << leg["instruction"]["summary"].gsub(/[\n]/, '').to_s
            else
              journ << "#{leg["instruction"]["summary"].gsub(/[\n]/, '')}, disruption: #{disruption["description"].gsub(/[\n]/, '')}"
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
      LocationExcuse.new(start_point: start, end_point: end_pt, lines_disrupted: excuse["line"], disruption_message: excuse["message"], journeys: excuse["journey"], journey_route: excuse["journey route"], transport_mode: excuse["transport_mode"])
    end
  end
end
