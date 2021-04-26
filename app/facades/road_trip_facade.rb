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
    current_time = Time.at(forecast[:current_weather][:dt])
    hours, minutes = travel_time.split(':')
    new_minutes = current_time.min + minutes.to_i
    new_hour = if new_minutes > 60
                  (current_time.hour + hours.to_i) + (new_minutes / 60)
               else
                  (current_time.hour + hours.to_i)
                end

    arrival_time = Time.new(current_time.year, current_time.month, current_time.day, new_hour, new_minutes % 60)

    eta_weather = forecast[:hourly_weather].find do |data|
      Time.at(data[:dt]).hour == arrival_time.hour
    end

    binding.pry
  end
end
