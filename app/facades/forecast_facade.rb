class ForecastFacade
  def self.get_forecast(location)
    current_weather = OpenWeatherService.current_weather(coordinates(location))
    CurrentWeather.new(current_weather)
  end

  def self.coordinates(location)
    coords = MapquestService.get_coordinates(location)
    Coordinate.new(coords)
  end
end
