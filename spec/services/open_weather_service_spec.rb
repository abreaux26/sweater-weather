require 'rails_helper'
RSpec.describe 'Open Weather Service' do
  describe 'happy path' do
    it '::current_weather(coordinates)' do
      VCR.use_cassette('open_weather_engine/current_weather') do
        coords = Coordinate.new({
            "lat": 39.738453,
            "lng": -104.984853
          })
        cw = OpenWeatherService.current_weather(coords)

        expect(cw).to be_a(Hash)
        expect(cw).to have_key(:dt)
        expect(cw).to have_key(:sunrise)
        expect(cw).to have_key(:sunset)
        expect(cw).to have_key(:temp)
        expect(cw).to have_key(:feels_like)
        expect(cw).to have_key(:humidity)
        expect(cw).to have_key(:uvi)
        expect(cw).to have_key(:visibility)
        expect(cw).to have_key(:weather)
        expect(cw[:weather].first).to have_key(:description)
        expect(cw[:weather].first).to have_key(:icon)
      end
    end
  end

  describe 'sad path' do
  end
end
