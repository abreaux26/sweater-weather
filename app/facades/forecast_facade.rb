class ForecastFacade
  def self.get_forecast(location)
    forecast = OpenWeatherService.forecast(coordinates(location))
    Forecast.new(forecast_data(forecast))
  end

  def self.forecast_data(forecast)
    {
      current_weather: current_weather(forecast[:current_weather]),
      daily_weather: daily_weather(forecast[:daily_weather]),
      hourly_weather: hourly_weather(forecast[:hourly_weather])
    }
  end

  def self.current_weather(current_weather)
    CurrentWeather.new(current_weather)
  end

  def self.daily_weather(daily_weather)
    daily_weather.map do |data|
      DailyWeather.new(data)
    end
  end

  def self.hourly_weather(hourly_weather)
    hourly_weather.map do |data|
      HourlyWeather.new(data)
    end
  end

  def self.coordinates(location)
    coords = MapquestService.get_coordinates(location)
    Coordinate.new(coords)
  end
end
