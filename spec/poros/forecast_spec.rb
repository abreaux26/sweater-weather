require 'rails_helper'

RSpec.describe Forecast do
  before :each do
    @current_data = {:dt=>1619286637,
                     :sunrise=>1619266137,
                     :sunset=>1619315203,
                     :temp=>54.99,
                     :feels_like=>52.72,
                     :pressure=>1023,
                     :humidity=>54,
                     :dew_point=>38.68,
                     :uvi=>6.7,
                     :clouds=>49,
                     :visibility=>10000,
                     :wind_speed=>3,
                     :wind_deg=>338,
                     :wind_gust=>8.01,
                     :weather=>[{:id=>802, :main=>'Clouds', :description=>'scattered clouds', :icon=>'03d'}]}
    @daily_data = {:dt=>1619287200,
                   :sunrise=>1619266137,
                   :sunset=>1619315203,
                   :moonrise=>1619305320,
                   :moonset=>1619262300,
                   :moon_phase=>0.41,
                   :temp=>{:day=>54.99, :min=>38.21, :max=>66.07, :night=>54.52, :eve=>65.26, :morn=>38.21},
                   :feels_like=>{:day=>52.72, :night=>38.21, :eve=>62.33, :morn=>38.21},
                   :pressure=>1023,
                   :humidity=>54,
                   :dew_point=>38.68,
                   :wind_speed=>6.87,
                   :wind_deg=>68,
                   :wind_gust=>8.63,
                   :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
                   :clouds=>49,
                   :pop=>0,
                   :uvi=>6.7}

    @hourly_data = { :dt=>1619283600,
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
                     :weather=>[{:id=>802, :main=>"Clouds", :description=>"scattered clouds", :icon=>"03d"}],
                     :pop=>0}

    @data = {
              current_weather: CurrentWeather.new(@current_data),
              daily_weather: DailyWeather.new(@daily_data),
              hourly_weather: HourlyWeather.new(@hourly_data)
            }

    @forecast = Forecast.new(@data)
  end

  it 'can be created' do
    expect(@forecast.class).to eq(Forecast)
  end

  it 'has valid attributes' do
    expect(@forecast.current_weather).to be_instance_of(CurrentWeather)
    expect(@forecast.daily_weather).to be_instance_of(DailyWeather)
    expect(@forecast.hourly_weather).to be_instance_of(HourlyWeather)
  end
end
