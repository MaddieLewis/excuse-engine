require 'HTTP'

APP_CODE = "n0K7Vhr8L2HsJuUBaR-Vlg"
APP_ID = "aQEtAgHGwVSbjtgKfmjq"

user_start_point = "51.518432,-0.126274"
user_end_point = "51.495354,-0.096062"

response = HTTP.get("https://traffic.api.here.com/traffic/6.3/incidents.json?app_id=#{APP_ID}&app_code=#{APP_CODE}&bbox=#{user_start_point};#{user_end_point}&maxresults=5&sort=criticalitydesc")
parsed = JSON.parse(response)
url = "https://traffic.api.here.com/traffic/6.3/incidents.json?app_id=#{APP_ID}&app_code=#{APP_CODE}&bbox=#{user_start_point};#{user_end_point}&maxresults=5&criticality=major"
p url
traffic_items = parsed["TRAFFIC_ITEMS"]["TRAFFIC_ITEM"]


traffic_items.each do |traffic_item|
  criticality = traffic_item['CRITICALITY']['DESCRIPTION']
  puts "-#{criticality.capitalize} traffic excuse-"
  e_tag = traffic_item['TRAFFIC_ITEM_TYPE_DESC']
  e_comments = traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').last
  e_start_date = traffic_item['START_TIME']
  e_area = traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').first
  geo = traffic_item['LOCATION']['GEOLOC']
  r_origin_lat = geo['ORIGIN']['LATITUDE']
  r_origin_long = geo['ORIGIN']['LONGITUDE']
  r_to_lat = geo['TO'][0]['LATITUDE']
  r_to_long = geo['TO'][0]['LONGITUDE']
  c_array = []
  c_array << [[r_origin_lat, r_origin_long], [r_origin_lat, r_origin_long]]
  unless geo['GEOMETRY']['SHAPES'].nil?
  coords = geo['GEOMETRY']['SHAPES']['SHP']
  coords.each do |line|
    all = line['value'].split(' ').map { |e| e.split(',') }
    if all.length > 2
    c_array << all
  else
    c_array << all
  end
  end
end
  c_array << [[r_to_lat, r_to_long], [r_to_lat, r_to_long]]
  e_message = "Traffic Alert: #{e_area}\nReason: #{e_comments}\nReported at: #{e_start_date}"
  e_area == "Past " ? e_area = traffic_item['LOCATION']['INTERSECTION']['ORIGIN']['STREET1']['ADDRESS1'] : e_area
  p c_array.flatten(1)
  # puts "Excuse tag: #{e_tag}"
  # puts "Comments: #{e_comments}"
  # puts "Started on: #{e_start_date}"
  # puts "Area affected: #{e_area}"
  # puts "Disruption begins: #{r_origin_lat}, #{r_origin_long}"
  # puts "Disruption ends: #{r_to_lat}, #{r_to_long}"
  #LocationExcuse.new(start_point: user_start_point, end_point: user_end_point, lines_disrupted: e_area, disruption_message: e_message, journeys: [], journey_route: [[r_origin_lat,r_origin_long],[r_to_lat,r_to_long]])
end


