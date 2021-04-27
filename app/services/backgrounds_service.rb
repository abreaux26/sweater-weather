class BackgroundsService
  def self.connection
    Faraday.new(url: 'https://api.pexels.com') do |req|
      req.authorization :Bearer, (ENV['pexels_key'])
    end
  end

  def self.get_background(location)
    response = connection.get('/v1/search') do |req|
      req.params['query'] = "downtown #{location}" unless location.blank?
    end
    data = JSON.parse(response.body, symbolize_names: true)
    data[:photos].first unless data[:photos].nil?
  end
end
