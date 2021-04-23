class MapquestService
  def self.connection
    Faraday.new(url: 'http://www.mapquestapi.com')
  end

  def self.get_coordinates(location)
    response = connection.get("geocoding/v1/address?key=#{ENV['mapquest_key']}&location=#{location}")
    data = JSON.parse(response.body, symbolize_names: true)
    Coordinate.new(data[:results][0][:locations].first[:latLng])
  end
end
