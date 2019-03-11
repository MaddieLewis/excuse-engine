require 'HTTP'

GM_API_KEY = ENV['GM_API_KEY']

origin = "51.518432,-0.126274"
destination = "51.495354,-0.096062"

url = "https://maps.googleapis.com/maps/api/directions/json?origin=#{origin}&destination=#{destination}&departure_time=now&traffic_model=pessimistic&key=#{GM_API_KEY}"
p url

http = HTTP.get(url)

response = JSON.parse(http)

arr = []
response['routes'].each do |route|
  route['legs'].each do |leg|
    p leg['duration_in_traffic']['text']
    leg['steps'].each do |step|
      p step['html_instructions']
      p step['distance']['text']
      p step['polyline']['points']
    end
  end
end
