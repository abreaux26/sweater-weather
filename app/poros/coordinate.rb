class Coordinate
  attr_reader :lat, :lng

  def initialize(data)
    @lat = data[:lat]
    @lng = data[:lng]
  end
end
