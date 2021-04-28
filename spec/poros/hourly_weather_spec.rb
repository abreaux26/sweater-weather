require 'rails_helper'

RSpec.describe HourlyWeather do
  before :each do
    @data = {:dt=>1619283600,
             :temp=>54.68,
             :feels_like=>52.16,
             :pressure=>1021,
             :humidity=>49,
             :dew_point=>35.92,
             :uvi=>5.34,
             :clouds=>47,
             :visibility=>10000,
             :wind_speed=>2.82,
             :wind_deg=>136,
             :wind_gust=>4.7,
             :weather=>[{:id=>802, :main=>'Clouds', :description=>'scattered clouds', :icon=>'03d'}],
             :pop=>0}

    @hourly_weather = HourlyWeather.new(@data)
  end

  it 'can be created' do
    expect(@hourly_weather.class).to eq(HourlyWeather)
  end

  it 'has valid attributes' do
    expect(@hourly_weather.time).to eq('12:00:00')
    expect(@hourly_weather.temperature).to eq(54.68)
    expect(@hourly_weather.conditions).to eq('scattered clouds')
    expect(@hourly_weather.icon).to eq('03d')
  end
end
