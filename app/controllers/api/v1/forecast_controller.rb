class Api::V1::ForecastController < ApplicationController
  def index
    current_weather = ForecastFacade.get_forecast(params[:location])
    render json: CurrentWeatherSerializer.new(current_weather)
  end
end
