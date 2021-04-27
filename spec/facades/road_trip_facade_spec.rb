require 'rails_helper'

RSpec.describe RoadTripFacade do
  before :each do
    @user1 = User.create( email: "whatever@example.com",
                          password: "password",
                          password_confirmation: "password"
                        )
    @road_trip_info = {
                        "origin": "Denver,CO",
                        "destination": "Pueblo,CO",
                        "api_key": @user1.api_key
                      }
  end

  describe "class methods" do
    it "::get_details(trip_info)" do
      VCR.use_cassette('facade/get_road_trip_details') do
        road_trip = RoadTripFacade.get_details(@road_trip_info)
        expect(road_trip).to be_instance_of(RoadTrip)
        expect(road_trip.start_city).to be_a(String)
        expect(road_trip.end_city).to be_a(String)
        expect(road_trip.travel_time).to be_a(String)
        expect(road_trip.weather_at_eta).to be_a(Hash)
        expect(road_trip.weather_at_eta[:temperature]).to be_a(Float)
        expect(road_trip.weather_at_eta[:conditions]).to be_a(String)
      end
    end

    it "::road_trip_data(road_trip)" do
      VCR.use_cassette('facade/road_trip_data') do
        road_trip = MapquestService.get_directions(@road_trip_info)
        road_trip_data = RoadTripFacade.road_trip_data(road_trip)
        expect(road_trip_data).to be_a(Hash)
        expect(road_trip_data).to have_key(:start_city)
        expect(road_trip_data).to have_key(:end_city)
        expect(road_trip_data).to have_key(:travel_time)
        expect(road_trip_data).to have_key(:weather_at_eta)
        expect(road_trip_data[:weather_at_eta]).to have_key(:temperature)
        expect(road_trip_data[:weather_at_eta]).to have_key(:conditions)

        expect(road_trip_data[:start_city]).to be_a(String)
        expect(road_trip_data[:end_city]).to be_a(String)
        expect(road_trip_data[:travel_time]).to be_a(String)
        expect(road_trip_data[:weather_at_eta]).to be_a(Hash)
        expect(road_trip_data[:weather_at_eta][:temperature]).to be_a(Float)
        expect(road_trip_data[:weather_at_eta][:conditions]).to be_a(String)
      end
    end

    it "::route_error(trip_info)" do
      VCR.use_cassette('facade/get_road_trip_details_impossible') do
        trip_info = {
                      "origin": "New York, NY",
                      "destination": "London, UK",
                      "api_key": @user1.api_key
                    }
        road_trip = RoadTripFacade.route_error(trip_info)

        expect(road_trip).to be_a(Hash)
        expect(road_trip[:start_city]).to be_a(String)
        expect(road_trip[:end_city]).to be_a(String)
        expect(road_trip[:travel_time]).to be_a(String)
        expect(road_trip[:weather_at_eta]).to be_a(Hash)
        expect(road_trip[:weather_at_eta]).to be_empty
      end
    end

    it "::current_weather(coords, travel_duration)" do
      VCR.use_cassette('facade/current_weather_daily') do
        trip_info = {
                      "origin": "New York, NY",
                      "destination": "Los Angeles, CA",
                      "api_key": @user1.api_key
                    }
        road_trip = MapquestService.get_directions(trip_info)
        coords = road_trip[:locations].last[:latLng]
        travel_duration = road_trip[:formattedTime]
        current_weather = RoadTripFacade.current_weather(coords, travel_duration)

        expect(current_weather).to be_a(Hash)
        expect(current_weather).to have_key(:temperature)
        expect(current_weather).to have_key(:conditions)

        expect(current_weather[:temperature]).to be_a(Float)
        expect(current_weather[:conditions]).to be_a(String)
      end
    end

    it '::arrival_time' do
      VCR.use_cassette('facade/arrival_time') do
        travel_duration = "09:00:00"
        current_time = DateTime.new(2021, 04, 26, 16)
        arrival_time = RoadTripFacade.arrival_time(travel_duration, current_time)

        expect(arrival_time).to eq(DateTime.new(2021, 04, 27, 01))
      end
    end

    it '::get_hour' do
      VCR.use_cassette('facade/get_hour') do
        hours = 9
        minutes = 0
        current_time = DateTime.new(2021, 04, 26, 16)
        hour = RoadTripFacade.get_hour(hours, minutes, current_time)

        expect(hour).to eq(25)
      end
    end

    it '::get_day' do
      VCR.use_cassette('facade/get_day') do
        hour = 25
        current_time = DateTime.new(2021, 04, 26, 16)
        hour = RoadTripFacade.get_day(hour, current_time)

        expect(hour).to eq(27)
      end
    end
  end

  describe 'sad paths' do
    it 'no origin'
    it 'no destination'
  end
end
