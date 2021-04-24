require 'rails_helper'

RSpec.describe ForecastFacade do
  describe "class methods" do
    it "::get_forecast" do
        data = ForecastFacade.get_forecast('denver,co')

        expect(data).to be_instance_of(CurrentWeather)
    end

    it "::coordinates" do
        data = ForecastFacade.coordinates('denver,co')

        expect(data).to be_instance_of(Coordinate)
    end
  end
end
