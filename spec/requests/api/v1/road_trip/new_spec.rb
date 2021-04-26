require 'rails_helper'
RSpec.describe 'Road Trip' do
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

  describe 'happy path' do
    it 'shows info for a road trip' do
      VCR.use_cassette('road_trip') do
        headers = {"CONTENT_TYPE" => "application/json"}
        post '/api/v1/road_trip', headers: headers, params: JSON.generate(@road_trip_info)

        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)

        expect(road_trip[:data][:attributes].count).to eq(4)

        expect(road_trip[:data]).to have_key(:id)
        expect(road_trip[:data]).to have_key(:type)
        expect(road_trip[:data][:attributes]).to have_key(:start_city)
        expect(road_trip[:data][:attributes]).to have_key(:end_city)
        expect(road_trip[:data][:attributes]).to have_key(:travel_time)
        expect(road_trip[:data][:attributes]).to have_key(:weather_at_eta)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)

        expect(road_trip[:data][:id]).to be_nil
        expect(road_trip[:data][:type]).to eq('roadtrip')
        expect(road_trip[:data][:attributes]).to be_a(Hash)
        expect(road_trip[:data][:attributes][:start_city]).to be_a(String)
        expect(road_trip[:data][:attributes][:end_city]).to be_a(String)
        expect(road_trip[:data][:attributes][:travel_time]).to be_a(String)
        expect(road_trip[:data][:attributes][:weather_at_eta]).to be_a(Hash)
        expect(road_trip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
        expect(road_trip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
      end
    end
  end

  describe 'sad path' do
    it 'impossible route' do
      VCR.use_cassette('road_trip/impossible_route') do
        impossible_route = {
                            "origin": "New York, NY",
                            "destination": "London, UK",
                            "api_key": @user1.api_key
                          }

        headers = {"CONTENT_TYPE" => "application/json"}
        post '/api/v1/road_trip', headers: headers, params: JSON.generate(impossible_route)

        road_trip = JSON.parse(response.body, symbolize_names: true)

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)

        expect(road_trip[:data][:attributes].count).to eq(4)

        expect(road_trip[:data][:attributes][:travel_time]).to eq("Impossible Route")
        expect(road_trip[:data][:attributes][:weather_at_eta]).to eq({})
      end
    end

    it 'invalid api key'
  end
end
