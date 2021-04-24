class Api::V1::ForecastController < ApplicationController
  before_action :invalid_location?

  def index
    return render_error('Invalid location.', :not_acceptable) if invalid_location?
    current_weather = ForecastFacade.get_forecast(params[:location])
    render json: CurrentWeatherSerializer.new(current_weather)
  end

  private
  def invalid_location?
    params[:location].nil? || params[:location].empty?
  end
end
