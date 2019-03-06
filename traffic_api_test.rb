require 'HTTP'


APP_CODE = "n0K7Vhr8L2HsJuUBaR-Vlg"
APP_ID = "aQEtAgHGwVSbjtgKfmjq"

user_start_point = "51.518432,-0.126274"
user_end_point = "51.495354,-0.096062"

response = HTTP.get("https://traffic.api.here.com/traffic/6.3/incidents.json?app_id=#{APP_ID}&app_code=#{APP_CODE}&bbox=#{user_start_point};#{user_end_point}")
parsed = JSON.parse(response)

traffic_items = parsed["TRAFFIC_ITEMS"]["TRAFFIC_ITEM"]

traffic = traffic_items.select do |traffic_item|
  criticality = traffic_item['CRITICALITY']['DESCRIPTION']
  criticality == "critical" || criticality == "major"

end

traffic.first(3).each do |traffic_item|
  criticality = traffic_item['CRITICALITY']['DESCRIPTION']
  puts "-#{criticality.capitalize} traffic excuse-"
  e_tag = traffic_item['TRAFFIC_ITEM_TYPE_DESC']
  e_comments = traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').last
  e_start_date = traffic_item['START_TIME']
  e_area = traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').first
  r_origin_lat = traffic_item['LOCATION']['GEOLOC']['ORIGIN']['LATITUDE']
  r_origin_long = traffic_item['LOCATION']['GEOLOC']['ORIGIN']['LONGITUDE']
  r_to_lat = traffic_item['LOCATION']['GEOLOC']['TO'][0]['LATITUDE']
  r_to_long = traffic_item['LOCATION']['GEOLOC']['TO'][0]['LONGITUDE']
  if e_area == "Past "
    e_area = traffic_item['LOCATION']['INTERSECTION']['ORIGIN']['STREET1']['ADDRESS1']
  else
    e_area
  end
  puts "Excuse tag: #{e_tag}"
  puts "Comments: #{e_comments}"
  puts "Started on: #{e_start_date}"
  puts "Area affected: #{e_area}"
  puts "Disruption begins: #{r_origin_lat}, #{r_origin_long}"
  puts "Disruption ends: #{r_to_lat}, #{r_to_long}"
end


