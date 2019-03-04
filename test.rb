require 'HTTP'

TFL_APP_ID = "abc3208f"
TFL_APP_KEY = "db291aa92151ac115d9f5f367ba115d5"
start = "E11%201JD"
end_pt = "IG2%207RP"
time = "1705"

response = HTTP.get("https://api-radon.tfl.gov.uk/Journey/JourneyResults/#{start}/to/#{end_pt}?time=#{time}&app_id=#{TFL_APP_ID}&app_key=#{TFL_APP_KEY}")

parsed = JSON.parse(response)

disrupted_journeys = []
parsed["lines"].each do |line|
  line["lineStatuses"].each do |line_status|
    p "The #{line_status["lineId"]} line has #{line_status["statusSeverityDescription"].downcase}"
    p "Reason: #{line_status["reason"]}"
  end
end
# parsed["journeys"].each_with_index do |journey, index|
#   p "Journey #{index + 1}, Travel Time: #{journey["duration"]} minutes"
#   journey["legs"].each_with_index do |leg, index|
#     if leg["disruptions"].empty?
#       p "leg #{index + 1}: #{leg["instruction"]["summary"]} - no disruptions"
#     else
#       leg["disruptions"].each do |disruption|
#         p "leg #{index + 1}: #{leg["instruction"]["summary"]}, disruption: #{disruption["description"]}"
#       end
#     end
#   end
# end
