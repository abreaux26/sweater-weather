class Api::V1::SalariesController < ApplicationController
  before_action :invalid_destination?

  def index
    return render_error('Invalid destination.') if invalid_destination?

    forecast = ForecastFacade.get_forecast(params[:destination])
    salary_data = SalariesFacade.get_salaries(params[:destination], forecast)
    render json: SalariesSerializer.new(salary_data)
  end
end
