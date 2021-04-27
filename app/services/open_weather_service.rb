class OpenWeatherService
  def self.connection
    Faraday.new(url: 'https://api.openweathermap.org') do |req|
      req.params['appid'] = ENV['open_weather_map_key']
    end
  end

  def self.get_data(coordinates)
    return "Invalid coordinates" unless coordinates.is_a?(Coordinate)

    response = connection.get("/data/2.5/onecall?lat=#{coordinates.lat}&lon=#{coordinates.lng}") do |req|
      req.params['units'] = 'imperial'
      req.params['exclude'] = 'minutely'
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.forecast(coordinates)
    data = get_data(coordinates)
    return "Forecast data unavailable" if data[:message]

    {
      current_weather: data[:current],
      daily_weather: data[:daily].first(5),
      hourly_weather: data[:hourly].first(8)
    }
  end
end
