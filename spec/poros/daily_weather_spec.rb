require 'rails_helper'

RSpec.describe DailyWeather do
  before :each do
    @data = {:dt=>1619287200,
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

    @dw = DailyWeather.new(@data)
  end

  it 'can be created' do
    expect(@dw.class).to eq(DailyWeather)
  end

  it 'has valid attributes' do
    expect(@dw.date).to eq('2021-04-24')
    expect(@dw.sunrise).to eq('2021-04-24 07:08:57 -0500')
    expect(@dw.sunset).to eq('2021-04-24 20:46:43 -0500')
    expect(@dw.max_temp).to eq(66.07)
    expect(@dw.min_temp).to eq(38.21)
    expect(@dw.conditions).to eq('scattered clouds')
    expect(@dw.icon).to eq('03d')
  end
end
