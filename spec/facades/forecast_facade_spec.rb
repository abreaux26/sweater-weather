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

    it "::coordinates" do
      VCR.use_cassette('facade/coordinates') do
        data = ForecastFacade.coordinates('denver,co')
        expect(data).to be_instance_of(Coordinate)
      end
    end
  end
end
