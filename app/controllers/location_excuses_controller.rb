class LocationExcusesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new show]
  before_action :set_location_excuse, only: :show

  TFL_APP_ID = "abc3208f"
  TFL_APP_KEY = "db291aa92151ac115d9f5f367ba115d5"

  def new
    @location_excuse = LocationExcuse.new
  end

  def create
    @location_excuse = LocationExcuse.new(location_excuse_params)
    @location_excuse.lines_disrupted = []
    @location_excuse.disruption_message = []
    find_excuses('')
    find_excuses('bus')
    find_excuses('bus,tube')
    if @location_excuse.save
      redirect_to location_excuse_path(@location_excuse)
    else
      render :new
    end
  end


  def show
    @all_journeys = find_journeys('')
    @bus = find_journeys('bus')
    @combined = find_journeys('bus,tube')
    @location_excuse.lines_disrupted.uniq
    @location_excuse.disruption_message.uniq
  end

  private

  def location_excuse_params
    params.require(:location_excuse).permit(:start_point, :end_point, :time)
  end

  def set_location_excuse
    @location_excuse = LocationExcuse.find(params[:id])
  end

  def find_excuses(mode)
    start = @location_excuse.start_point.gsub(/ /, "%20")
    end_pt = @location_excuse.end_point.gsub(/ /, "%20")

    response = HTTP.get("https://api-radon.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?&mode=#{mode}&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")

    parsed = JSON.parse(response)

    parsed["lines"].each do |line|
      line["lineStatuses"].each do |line_status|
        if !line_status["lineId"].nil?
          @location_excuse.lines_disrupted << line_status["lineId"]
          @location_excuse.disruption_message << line_status["reason"]
        end
      end
    end
  end

  def find_journeys(mode)
    start = @location_excuse.start_point.gsub(/ /, "%20")
    end_pt = @location_excuse.end_point.gsub(/ /, "%20")

    response = HTTP.get("https://api-radon.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?&mode=#{mode}&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")
    all = []
    parsed = JSON.parse(response)
    parsed["journeys"].each_with_index do |journey, index|
      arr = []
      arr << "Journey #{index + 1}, Travel Time: #{journey["duration"]} minutes"
      journey["legs"].each_with_index do |leg, leg_index|
        if leg["disruptions"].empty?
          arr << "leg #{leg_index + 1}: #{leg["instruction"]["summary"]}"
        else
          leg["disruptions"].each do |disruption|
            if disruption["category"] == "PlannedWork"
              arr << "leg #{leg_index + 1}: #{leg["instruction"]["summary"]}"
            else
              arr << "leg #{leg_index + 1}: #{leg["instruction"]["summary"]}, disruption: #{disruption["description"]}"
            end
          end
        end
        all << arr.uniq
      end
    end
    return all
  end
end
