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

critical_traffic.first(5).each do |traffic_item|
  puts e_tag = "Excuse tag: #{traffic_item['TRAFFIC_ITEM_TYPE_DESC']}"
  puts e_comments = "Comments: #{traffic_item['TRAFFIC_ITEM_DESCRIPTION']}"
  puts e_start = "Started on: #{traffic_item['START_TIME']}"
  puts e_area = "Area affected: #{traffic_item['TRAFFIC_ITEM_DESCRIPTION'][0]['value']}"
end

major_traffic = traffic_items.select do |traffic_item|
  traffic_item['CRITICALITY']['DESCRIPTION'] == "major"
end


