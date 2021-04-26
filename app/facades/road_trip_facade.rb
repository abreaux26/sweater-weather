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
      weather_at_eta: current_weather(road_trip[:locations].last[:latLng], road_trip[:formattedTime])
    }
  end

  def self.city(location)
    "#{location[:adminArea5]}, #{location[:adminArea3]}"
  end

  def self.current_weather(coords, travel_duration)
    forecast = OpenWeatherService.forecast(Coordinate.new(coords))

    arrival_time = arrival_time(travel_duration, forecast[:current_weather][:dt])

    eta_weather = forecast[:hourly_weather].find do |data|
      Time.at(data[:dt]).hour == arrival_time.hour
    end

    {
      temperature: eta_weather[:temp],
      conditions: eta_weather[:weather].first[:description]
    }
  end

  def self.arrival_time(travel_duration, current_time)
    current_time = Time.at(current_time)

    hours, minutes = travel_duration.split(':')

    new_minutes = current_time.min + minutes.to_i
    new_hour = if new_minutes > 60
                 (current_time.hour + hours.to_i) + (new_minutes / 60)
               else
                 (current_time.hour + hours.to_i)
               end

    Time.new(current_time.year, current_time.month, current_time.day, new_hour, new_minutes % 60)
  end
end
