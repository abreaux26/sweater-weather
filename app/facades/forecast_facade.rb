class ForecastFacade
  def self.get_forecast(params)
    # conn = Faraday.new(url: 'http://www.mapquestapi.com')
    # response = conn.get("geocoding/v1/address?key=#{ENV['mapquest_key']}&location=#{params[:location]}")
    # data = JSON.parse(response.body, symbolize_names: true)
    # coordinates = Coordinate.new(data[:results][0][:locations].first[:latLng])

    coordinates = MapquestService.get_coordinates(params[:location])
    
    conn_2 = Faraday.new(url: 'https://api.openweathermap.org')
    response_2 = conn_2.get("/data/2.5/onecall?lat=#{coordinates.lat}&lon=#{coordinates.lng}&appid=#{ENV['open_weather_map_key']}")
    data_2 = JSON.parse(response_2.body, symbolize_names: true)
    CurrentWeather.new(data_2[:current])
  end
end
