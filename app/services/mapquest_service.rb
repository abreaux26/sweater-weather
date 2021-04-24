class MapquestService
  def self.connection
    Faraday.new(url: 'https://www.mapquestapi.com') do |req|
      req.params['key'] = ENV['mapquest_key']
    end
  end

  def self.get_coordinates(location)
    response = connection.get("/geocoding/v1/address?location=#{location}")
    data = JSON.parse(response.body, symbolize_names: true)
    Coordinate.new(data[:results].first[:locations].first[:latLng])
  end
end
