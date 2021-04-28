require 'rails_helper'

RSpec.describe CurrentWeather do
  before :each do
    @data = {:dt=>1619286637,
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

    @cw = CurrentWeather.new(@data)
  end

  it 'can be created' do
    expect(@cw.class).to eq(CurrentWeather)
  end

  it 'has valid attributes' do
    expect(@cw.datetime).to eq('2021-04-24 12:50:37 -0500')
    expect(@cw.sunrise).to eq('2021-04-24 07:08:57 -0500')
    expect(@cw.sunset).to eq('2021-04-24 20:46:43 -0500')
    expect(@cw.temperature).to eq(54.99)
    expect(@cw.feels_like).to eq(52.72)
    expect(@cw.humidity).to eq(54)
    expect(@cw.uvi).to eq(6.7)
    expect(@cw.visibility).to eq(10000)
    expect(@cw.conditions).to eq('scattered clouds')
    expect(@cw.icon).to eq('03d')
  end
end
