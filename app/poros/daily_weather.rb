class DailyWeather
  attr_reader :date,
              :sunrise,
              :sunset,
              :max_temp,
              :min_temp,
              :conditions,
              :icon

  def initialize(data)
    @date = Time.zone.at(data[:dt]).strftime('%Y-%m-%d')
    @sunrise = Time.zone.at(data[:sunrise]).strftime('%Y-%m-%d %H:%M:%S %z')
    @sunset = Time.zone.at(data[:sunset]).strftime('%Y-%m-%d %H:%M:%S %z')
    @max_temp = data[:temp][:max]
    @min_temp = data[:temp][:min]
    @conditions = data[:weather].first[:description]
    @icon = data[:weather].first[:icon]
  end
end
