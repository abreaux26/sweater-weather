class CurrentWeatherSerializer
  include FastJsonapi::ObjectSerializer
  set_id nil
  attributes :datetime,
             :sunrise,
             :sunset,
             :temperature,
             :feels_like,
             :humidity,
             :uvi,
             :visibility,
             :conditions,
             :icon
end
