require 'rails_helper'
RSpec.describe 'Open Weather Service' do
  describe 'happy path' do
    it '::forecast(coordinates)' do
      VCR.use_cassette('open_weather_engine/forecast') do
        coords = Coordinate.new({
            "lat": 39.738453,
            "lng": -104.984853
          })
        forecast = OpenWeatherService.forecast(coords)

        expect(forecast).to be_a(Hash)
        expect(forecast).to have_key(:current_weather)
        expect(forecast).to have_key(:daily_weather)
        expect(forecast).to have_key(:hourly_weather)

        expect(forecast[:daily_weather].size).to eq(5)
        expect(forecast[:hourly_weather].size).to eq(8)
      end
    end
  end

  describe 'sad path' do
  end
end
