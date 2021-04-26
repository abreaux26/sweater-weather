class RoadTripFacade
  def self.get_details(trip_info)
    road_trip = MapquestService.get_directions(trip_info)
    return RoadTrip.new(route_error(trip_info)) if (road_trip[:routeError][:errorCode]).positive?

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

  def self.route_error(trip_info)
    {
      start_city: trip_info[:origin],
      end_city: trip_info[:destination],
      travel_time: 'Impossible Route',
      weather_at_eta: {}
    }
  end

  def self.city(location)
    "#{location[:adminArea5]}, #{location[:adminArea3]}"
  end

  def self.current_weather(coords, travel_duration)
    forecast = OpenWeatherService.forecast(Coordinate.new(coords))
    current_time = Time.zone.at(forecast[:current_weather][:dt])

    arrival_time = arrival_time(travel_duration, current_time)

    eta_weather = if current_time.day < arrival_time.day
                    eta_weather(forecast[:daily_weather], arrival_time)
                  else
                    eta_weather(forecast[:hourly_weather], arrival_time, false)
                  end

    {
      temperature: eta_weather[:temp],
      conditions: eta_weather[:weather].first[:description]
    }
  end

  def self.eta_weather(forecast, arrival_time, daily = true)
    forecast.find do |data|
      if daily
        Time.zone.at(data[:dt]).day == arrival_time.day
      else
        Time.zone.at(data[:dt]).hour == arrival_time.hour
      end
    end
  end

  def self.arrival_time(travel_duration, current_time)
    hours, minutes = travel_duration.split(':')

    new_minutes = current_time.min + minutes.to_i
    new_hour = if new_minutes > 60
                 (current_time.hour + hours.to_i) + (new_minutes / 60)
               else
                 (current_time.hour + hours.to_i)
               end

    day = if new_hour > 24
            current_time.day + new_hour / 24
          else
            current_time.day
          end

    Time.zone.local(current_time.year, current_time.month, day, new_hour % 24, new_minutes % 60)
  end
end
