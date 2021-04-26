class Api::V1::SalariesController < ApplicationController
  # include ActionView::Helpers::NumberHelper
  before_action :invalid_destination?

  def index
    return render_error('Invalid destination.') if invalid_destination?

    forecast = ForecastFacade.get_forecast(params[:destination])
    salary_info = SalariesFacade.get_salaries(params[:destination], forecast)

    render json: SalariesSerializer.new(Salary.new(salary_info))
  end
end
