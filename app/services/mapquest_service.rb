class MapquestService
  def self.connection
    Faraday.new(url: 'https://www.mapquestapi.com') do |req|
      req.params['key'] = ENV['mapquest_key']
    end
  end

  def self.get_coordinates(location)
    response = connection.get('/geocoding/v1/address') do |req|
      req.params['location'] = location
    end
    data = JSON.parse(response.body, symbolize_names: true)
    data[:results].first[:locations].first[:latLng] unless data[:info][:statuscode] > 0
  end

  def self.get_directions(trip_info)
    response = connection.get('/directions/v2/route') do |req|
      req.params['from'] = trip_info[:origin]
      req.params['to'] = trip_info[:destination]
    end
    data = JSON.parse(response.body, symbolize_names: true)
    return "Invalid route" if data[:info][:statuscode].positive?
    data[:route]
  end
end
