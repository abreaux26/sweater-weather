class CurrentWeather
  attr_reader :datetime,
              :sunrise,
              :sunset,
              :temperature,
              :feels_like,
              :humidity,
              :uvi,
              :visibility,
              :conditions,
              :icon

  def initialize(data)
    @datetime = Time.zone.at(data[:dt]).strftime('%Y-%m-%d %H:%M:%S %z')
    @sunrise = Time.zone.at(data[:sunrise]).strftime('%Y-%m-%d %H:%M:%S %z')
    @sunset = Time.zone.at(data[:sunset]).strftime('%Y-%m-%d %H:%M:%S %z')
    @temperature = data[:temp]
    @feels_like = data[:feels_like]
    @humidity = data[:humidity]
    @uvi = data[:uvi]
    @visibility = data[:visibility]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
