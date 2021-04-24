class OpenWeatherService
  def self.connection
    Faraday.new(url: 'https://api.openweathermap.org') do |req|
      req.params['appid'] = ENV['open_weather_map_key']
    end
  end

  def self.get_data(coordinates)
    response = connection.get("/data/2.5/onecall?lat=#{coordinates.lat}&lon=#{coordinates.lng}&units=imperial")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.forecast(coordinates)
    data = get_data(coordinates)
    {
      current_weather: data[:current],
      daily_weather: data[:daily].first(5),
      hourly_weather: data[:hourly].first(8)
    }
  end
end
