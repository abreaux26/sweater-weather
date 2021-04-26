class RoadTripFacade
  def self.get_details(trip_info)
    road_trip = MapquestService.get_directions(trip_info)
    RoadTrip.new(road_trip_data(road_trip))
  end

  def self.road_trip_data(road_trip)
    {
      start_city: city(road_trip[:route][:locations].first),
      end_city: city(road_trip[:route][:locations].last),
      travel_time: road_trip[:route][:formattedTime],
      weather_eta_at: current_weather(road_trip[:destination_coords], road_trip[:route][:formattedTime])
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
    binding.pry
  end

  # def self.arrival_time(???)
  #
  # end
end
