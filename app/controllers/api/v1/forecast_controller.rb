class Api::V1::ForecastController < ApplicationController
  before_action :invalid_location?

  def index
    return render_error('Invalid location.', :not_acceptable) if invalid_location?
    forecast = ForecastFacade.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end

  private
  def invalid_location?
    params[:location].nil? || params[:location].empty?
  end
end
