class ForecastFacade
  def self.get_forecast(location)
    OpenWeatherService.current_weather(coordinates(location))
  end

  def self.coordinates(location)
    coords = MapquestService.get_coordinates(location)
    Coordinate.new(coords)
  end
end
