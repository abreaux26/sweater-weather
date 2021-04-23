class ForecastFacade
  def self.get_forecast(params)
    coordinates = MapquestService.get_coordinates(params[:location])

    # conn_2 = Faraday.new(url: 'https://api.openweathermap.org')
    # response_2 = conn_2.get("/data/2.5/onecall?lat=#{coordinates.lat}&lon=#{coordinates.lng}&appid=#{ENV['open_weather_map_key']}")
    # data_2 = JSON.parse(response_2.body, symbolize_names: true)
    # CurrentWeather.new(data_2[:current])
    OpenWeatherService.current_weather(coordinates)
  end
end
