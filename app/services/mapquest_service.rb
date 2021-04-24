class MapquestService
  def self.connection
    Faraday.new(url: 'https://www.mapquestapi.com') do |req|
      req.params['key'] = ENV['mapquest_key']
    end
  end

  def self.get_data(url)
    response = connection.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_coordinates(location)
    data = get_data("/geocoding/v1/address?location=#{location}")
    Coordinate.new(data[:results].first[:locations].first[:latLng])
  end
end
