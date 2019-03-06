require 'HTTP'


APP_CODE = "n0K7Vhr8L2HsJuUBaR-Vlg"
APP_ID = "aQEtAgHGwVSbjtgKfmjq"


# base_url = "https://traffic.api.here.com"
# path = "/traffic/6.3/"
# resource_inc = "incidents"
# resource_flow = "flowavailability"

response = HTTP.get("https://traffic.api.here.com/traffic/6.3/incidents.json?app_id=#{APP_ID}&app_code=#{APP_CODE}&bbox=51.518432,-0.126274;51.495354,-0.096062")
parsed = JSON.parse(response)

traffic_items = parsed["TRAFFIC_ITEMS"]["TRAFFIC_ITEM"]

critical_traffic = traffic_items.select do |traffic_item|
  traffic_item['CRITICALITY']['DESCRIPTION'] == "critical"
end

critical_traffic.first(2).each do |traffic_item|
  puts e_tag = "Excuse tag: #{traffic_item['TRAFFIC_ITEM_TYPE_DESC'].capitalize}"
  puts e_comments = "Comments: #{traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').last}"
  puts e_start_date = "Started on: #{traffic_item['START_TIME']}"
  puts e_area = "Area affected: #{traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value'].split(' - ').first}"
  r_origin_lat = "#{traffic_item['LOCATION']['GEOLOC']['ORIGIN']['LATITUDE']}"
  r_origin_long = "#{traffic_item['LOCATION']['GEOLOC']['ORIGIN']['LONGITUDE']}"
  puts "Disrupted route begins: #{r_origin_lat}, #{r_origin_long}"
  r_to_lat = "#{traffic_item['LOCATION']['GEOLOC']['TO'][0]['LATITUDE']}"
  r_to_long = "#{traffic_item['LOCATION']['GEOLOC']['TO'][0]['LONGITUDE']}"
  puts "Disrupted route ends: #{r_to_lat}, #{r_to_long}"
end

major_traffic = traffic_items.select do |traffic_item|
  traffic_item['CRITICALITY']['DESCRIPTION'] == "major"
end


