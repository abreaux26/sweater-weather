require 'rails_helper'

RSpec.describe ForecastFacade do
  describe "class methods" do
    it "::get_forecast" do
      VCR.use_cassette('facade/get_forecast') do
        forecast = ForecastFacade.get_forecast('denver,co')
        expect(forecast).to be_instance_of(Forecast)
        expect(forecast.current_weather).to be_instance_of(CurrentWeather)
        expect(forecast.daily_weather).to be_an(Array)
        expect(forecast.hourly_weather).to be_an(Array)

        forecast.daily_weather.each do |daily_weather|
          expect(daily_weather).to be_instance_of(DailyWeather)
        end

        forecast.hourly_weather.each do |hourly_weather|
          expect(hourly_weather).to be_instance_of(HourlyWeather)
        end
      end
    end

    it "::forecast_data" do
      VCR.use_cassette('facade/forecast_data') do
        coords = Coordinate.new({
            "lat": 39.738453,
            "lng": -104.984853
          })
        forecast = OpenWeatherService.forecast(coords)
        data = ForecastFacade.forecast_data(forecast)

        expect(data).to be_a(Hash)
        expect(data).to have_key(:current_weather)
        expect(data).to have_key(:daily_weather)
        expect(data).to have_key(:hourly_weather)
      end
    end

    it "::current_weather" do
      VCR.use_cassette('facade/current_weather') do
        coords = Coordinate.new({
            "lat": 39.738453,
            "lng": -104.984853
          })
        forecast = OpenWeatherService.forecast(coords)
        data = ForecastFacade.current_weather(forecast[:current_weather])

        expect(data).to be_instance_of(CurrentWeather)
      end
    end

    it "::daily_weather" do
      VCR.use_cassette('facade/daily_weather') do
        coords = Coordinate.new({
            "lat": 39.738453,
            "lng": -104.984853
          })
        forecast = OpenWeatherService.forecast(coords)
        data = ForecastFacade.daily_weather(forecast[:daily_weather])

        expect(data).to be_an(Array)
        expect(data.size).to eq(5)
      end
    end

    it "::hourly_weather" do
      VCR.use_cassette('facade/hourly_weather') do
        coords = Coordinate.new({
            "lat": 39.738453,
            "lng": -104.984853
          })
        forecast = OpenWeatherService.forecast(coords)
        data = ForecastFacade.hourly_weather(forecast[:hourly_weather])

        expect(data).to be_an(Array)
        expect(data.size).to eq(8)
      end
    end

    it "::coordinates" do
      VCR.use_cassette('facade/coordinates') do
        data = ForecastFacade.coordinates('denver,co')
        expect(data).to be_instance_of(Coordinate)
      end
    end
  end

  describe 'sad paths' do
    it 'no location' do
      VCR.use_cassette('facade/sad_path/no_location') do
        forecast = ForecastFacade.get_forecast('')
        expect(forecast).to eq('Forecast data unavailable.')
      end
    end

    it 'invalid coords' do
      VCR.use_cassette('facade/sad_path/invalid_coords') do
        data = ForecastFacade.coordinates('')
        expect(data).to eq('Invalid coordinates')
      end
    end
  end
end
