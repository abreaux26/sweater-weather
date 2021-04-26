class Salary
  attr_reader :id, :destination, :forecast, :salaries

  def initialize(data)
    @destination = data[:destination]
    @forecast = data[:forecast]
    @salaries = data[:salaries]
  end
end
