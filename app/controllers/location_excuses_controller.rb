class LocationExcusesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new show create]
  before_action :set_location_excuse, only: :show

  TFL_APP_ID = "abc3208f"
  TFL_APP_KEY = "db291aa92151ac115d9f5f367ba115d5"

  def new
    @location_excuse = LocationExcuse.new
  end

  def create
    @location_excuse = LocationExcuse.new(location_excuse_params)
    all = find_excuses('') + find_excuses('bus') + find_excuses('bus,tube')
    all_excuses = all.uniq.map { |excuse| new_loop(excuse) }

    unless all_excuses.empty?
      all_excuses.map do |excuse|
        unless excuse&.lines_disrupted.nil? || excuse&.disruption_message.nil?
          unless excuse.save
            render :new
          end
        end
      end
    end

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
    params.require(:location_excuse).permit(:start_point, :end_point, :journeys)
  end

  def set_location_excuse
    @location_excuse = LocationExcuse.find(params[:id])
  end

  def api_call(mode)
    start = @location_excuse.start_point.gsub(/ /, "%20")
    end_pt = @location_excuse.end_point.gsub(/ /, "%20")
    response = HTTP.get("https://api-radon.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?&mode=#{mode}&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")
    JSON.parse(response)
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
          end
        end
        arr << hash
      end
    end
    arr.uniq
  end

  def find_journeys(mode)
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
      arr << journ if journ.join.include?("disruption:")
    end
    arr.uniq
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
      LocationExcuse.new(start_point: start, end_point: end_pt, lines_disrupted: [excuse["line"]], disruption_message: [excuse["message"]], journeys: excuse["journey"])
    end
  end
end
