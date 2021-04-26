class UrbanAreaService
  def self.connection
    Faraday.new(url: 'https://api.teleport.org')
  end

  def self.get_data(destination)
    response = connection.get("/api/urban_areas/slug:#{destination}/salaries/")
    JSON.parse(response.body, symbolize_names: true)
  end
end
