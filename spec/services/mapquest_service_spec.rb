require 'rails_helper'
RSpec.describe 'Mapquest Service' do
  describe 'happy path' do
    it '::get_coordinates(location)' do
      VCR.use_cassette('mapquest_service/coordinates') do
        coords = MapquestService.get_coordinates('denver,co')

        expect(coords).to be_a(Hash)
        expect(coords).to have_key(:lat)
        expect(coords).to have_key(:lng)

        expect(coords[:lat]).to be_a(Float)
        expect(coords[:lng]).to be_a(Float)
      end
    end

    it '::get_directions(trip_info)' do
      VCR.use_cassette('mapquest_service/directions') do
        user1 = User.create( email: "whatever@example.com",
                              password: "password",
                              password_confirmation: "password"
                            )
        road_trip_info = {
                            "origin": "Denver,CO",
                            "destination": "Pueblo,CO",
                            "api_key": user1.api_key
                          }

        directions = MapquestService.get_directions(road_trip_info)

        expect(directions).to be_a(Hash)
        expect(directions).to have_key(:locations)
        expect(directions).to have_key(:formattedTime)
      end
    end
  end

  describe 'sad path' do
    it 'no origin' do
      VCR.use_cassette('mapquest_service/sad_path/no_origin') do
        user1 = User.create( email: "whatever@example.com",
                              password: "password",
                              password_confirmation: "password"
                            )
        road_trip_info = {
                            "destination": "Pueblo,CO",
                            "api_key": user1.api_key
                          }

        directions = MapquestService.get_directions(road_trip_info)
        expect(directions).to eq("Invalid route")
      end
    end

    it 'no destination' do
      VCR.use_cassette('mapquest_service/sad_path/no_destination') do
        user1 = User.create( email: "whatever@example.com",
                              password: "password",
                              password_confirmation: "password"
                            )
        road_trip_info = {
                            "origin": "Pueblo,CO",
                            "api_key": user1.api_key
                          }

        directions = MapquestService.get_directions(road_trip_info)
        expect(directions).to eq("Invalid route")
      end
    end

    it 'impossible route' do
      VCR.use_cassette('mapquest_service/sad_path/impossible_route') do
        user1 = User.create( email: "whatever@example.com",
                              password: "password",
                              password_confirmation: "password"
                            )
        road_trip_info = {
                            "origin": "New York, NY",
                            "destination": " London, UK",
                            "api_key": user1.api_key
                          }

        directions = MapquestService.get_directions(road_trip_info)
        expect(directions).to eq("Invalid route")
      end
    end
  end
end
