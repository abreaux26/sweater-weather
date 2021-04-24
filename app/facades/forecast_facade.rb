class ForecastFacade
  def self.get_forecast(location)
    coordinates = MapquestService.get_coordinates(location)
    OpenWeatherService.current_weather(coordinates)
  end
end
