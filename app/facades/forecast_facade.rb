class ForecastFacade
  def self.get_forecast(location)
    forecast = OpenWeatherService.forecast(coordinates(location))

    current_weather = CurrentWeather.new(forecast[:current_weather])

    daily_weather = forecast[:daily_weather].map do |data|
      DailyWeather.new(data)
    end

    hourly_weather = forecast[:hourly_weather].map do |data|
      HourlyWeather.new(data)
    end

    Forecast.new(current_weather, daily_weather, hourly_weather)
  end

  def self.coordinates(location)
    coords = MapquestService.get_coordinates(location)
    Coordinate.new(coords)
  end
end
