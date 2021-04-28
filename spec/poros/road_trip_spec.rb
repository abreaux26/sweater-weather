require 'rails_helper'

RSpec.describe RoadTrip do
  before :each do
    @data = { :start_city=>"Denver, CO",
              :end_city=>"Pueblo, CO",
              :travel_time=>"01:44:22",
              :weather_at_eta=> { :temperature=>81.09,
                                  :conditions=>"few clouds"}}

    @road_trip = RoadTrip.new(@data)
  end

  it 'can be created' do
    expect(@road_trip.class).to eq(RoadTrip)
  end

  it 'has valid attributes' do
    expect(@road_trip.start_city).to eq("Denver, CO")
    expect(@road_trip.end_city).to eq("Pueblo, CO")
    expect(@road_trip.travel_time).to eq("01:44:22")
    expect(@road_trip.weather_at_eta).to be_a(Hash)
    expect(@road_trip.weather_at_eta[:temperature]).to eq(81.09)
    expect(@road_trip.weather_at_eta[:conditions]).to eq("few clouds")
  end
end
