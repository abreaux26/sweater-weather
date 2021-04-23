class Api::V1::ForecastController < ApplicationController
  def index
    cw = ForecastFacade.get_forecast(params)
    render json: CurrentWeatherSerializer.new(cw)
  end
end
