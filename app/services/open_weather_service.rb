class OpenWeatherService
  def self.connection
    Faraday.new(url: 'https://api.openweathermap.org') do |req|
      req.params['appid'] = ENV['open_weather_map_key']
    end
  end

  def self.get_data(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.current_weather(coordinates)
    data = get_data("/data/2.5/onecall?lat=#{coordinates.lat}&lon=#{coordinates.lng}&units=imperial")
    data[:current]
  end
end
