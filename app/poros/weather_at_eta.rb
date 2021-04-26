class WeatherAtEta
  attr_reader: :temperature, :conditions

  def initialize(data)
    @temperature = data[:temp]
    @conditions = data[:conditions]
  end
end
