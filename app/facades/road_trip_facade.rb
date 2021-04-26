class RoadTripFacade
  def self.get_details(trip_info)
    road_trip = MapquestService.get_directions(trip_info)
    RoadTrip.new(road_trip_data(road_trip))
  end

  def self.road_trip_data(road_trip)
    {
      start_city: city(road_trip[:locations].first),
      end_city: city(road_trip[:locations].last),
      travel_time: road_trip[:formattedTime],
      weather_eta_at: current_weather(road_trip[:locations].last[:latLng], road_trip[:formattedTime])
    }
  end

  def self.city(location)
    "#{location[:adminArea5]}, #{location[:adminArea3]}"
  end

  def self.current_weather(coords, travel_time)
    forecast = OpenWeatherService.forecast(Coordinate.new(coords))
    x = forecast[:hourly_weather].map do |data|
      HourlyWeather.new(data)
    end
    # binding.pry
  end

  # def self.arrival_time(???)
  #
  # end
end
