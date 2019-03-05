require 'HTTP'

TFL_APP_ID = "abc3208f"
TFL_APP_KEY = "db291aa92151ac115d9f5f367ba115d5"
start = "SW7%202HL"
end_pt = "E2%208DY"
time = "0700"

response = HTTP.get("https://api-radon.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?time=#{time}&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")
bus = HTTP.get("https://api-radon.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?time=#{time}&mode=bus&app_id=abc3208f&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")
tube_bus = HTTP.get("https://api-radon.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?time=#{time}&mode=tube,bus&app_id=abc3208f&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")

parsed = JSON.parse(response)
bus_parsed = JSON.parse(bus)
tube_bus_parsed = JSON.parse(tube_bus)

p "TUBE JOURNEY"
p "LINE DISRUPTIONS"
parsed["lines"].each do |line|
  line["lineStatuses"].each do |line_status|
    unless [0, 10].include?(line_status["statusSeverity"])
      p "The #{line_status["lineId"]} line has #{line_status["statusSeverityDescription"].downcase}"
      p "Reason: #{line_status["reason"]}"
    end
  end
end

p "JOURNEY DISRUPTIONS"
parsed["journeys"].each_with_index do |journey, index|
  p "Journey #{index + 1}, Travel Time: #{journey["duration"]} minutes"
  journey["legs"].each_with_index do |leg, index|
    if leg["disruptions"].empty?
      p "leg #{index + 1}: #{leg["instruction"]["summary"]}"
    else
      leg["disruptions"].each do |disruption|
        if disruption["category"] == "PlannedWork"
          p "leg #{index + 1}: #{leg["instruction"]["summary"]}"
        else
          p "leg #{index + 1}: #{leg["instruction"]["summary"]}, disruption: #{disruption["description"]}"
        end
      end
    end
  end
end

p "BUS JOURNEY"
p "LINE DISRUPTIONS"
bus_parsed["lines"].each do |line|
  line["lineStatuses"].each do |line_status|
    unless [0, 10].include?(line_status["statusSeverity"])
      p "The #{line_status["lineId"]} line has #{line_status["statusSeverityDescription"].downcase}"
      p "Reason: #{line_status["reason"]}"
    end
  end
end
p "JOURNEYS"
bus_parsed["journeys"].each_with_index do |journey, index|
  p "Journey #{index + 1}, Travel Time: #{journey["duration"]} minutes"
  journey["legs"].each_with_index do |leg, index|
    if leg["disruptions"].empty?
      p "leg #{index + 1}: #{leg["instruction"]["summary"]}"
    else
      leg["disruptions"].each do |disruption|
        if disruption["category"] == "PlannedWork"
          p "leg #{index + 1}: #{leg["instruction"]["summary"]}"
        else
          p "leg #{index + 1}: #{leg["instruction"]["summary"]}, disruption: #{disruption["description"]}"
        end
      end
    end
  end
end

p "MIXED JOURNEY"
p "LINE DISRUPTIONS"
tube_bus_parsed["lines"].each do |line|
  line["lineStatuses"].each do |line_status|
    unless [0, 10].include?(line_status["statusSeverity"])
      p "The #{line_status["lineId"]} line has #{line_status["statusSeverityDescription"].downcase}"
      p "Reason: #{line_status["reason"]}"
    end
  end
end
p "JOURNEYS"
tube_bus_parsed["journeys"].each_with_index do |journey, index|
  p "Journey #{index + 1}, Travel Time: #{journey["duration"]} minutes"
  journey["legs"].each_with_index do |leg, index|
    if leg["disruptions"].empty?
      p "leg #{index + 1}: #{leg["instruction"]["summary"]}"
    else
      leg["disruptions"].each do |disruption|
        if disruption["category"] == "PlannedWork"
          p "leg #{index + 1}: #{leg["instruction"]["summary"]}"
        else
          p "leg #{index + 1}: #{leg["instruction"]["summary"]}, disruption: #{disruption["description"]}"
        end
      end
    end
  end
end
