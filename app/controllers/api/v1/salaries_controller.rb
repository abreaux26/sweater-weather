class Api::V1::SalariesController < ApplicationController
  before_action :invalid_destination?

  def index
    return render_error('Invalid destination.') if invalid_destination?

    forecast = ForecastFacade.get_forecast(params[:destination])

    response = Faraday.get("https://api.teleport.org/api/cities/") do |req|
      req.params['search'] = params[:destination]
      req.params['embed'] = 'city:search-results/city:item/city:urban_area/ua:scores'
    end
    binding.pry
    data = JSON.parse(response.body, symbolize_names: true)

    ua_id = data[:_embedded][:'city:search-results'].first[:_embedded][:'city:item'][:_embedded][:'city:urban_area'][:ua_id]

    salaries = Faraday.get("https://api.teleport.org/api/cities/") do |req|
      req.params['search'] = params[:destination]
      req.params['embed'] = 'city:search-results/city:item/city:urban_area/ua:scores'
    end
    salary_data = JSON.parse(response.body, symbolize_names: true)

    # salary_info = {
    #   destination: params[:destination],
    #   forecast: salary_forecast(forecast),
    #   salaries: salary_info(???)
    # }

    render json: SalariesSerializer.new()
  end

  private
  def salary_forecast(forecast)
    {
      summary: forecast.conditions,
      temperature: forecast.temperature
    }
  end

  # def salary_info(???)
  # end
end
