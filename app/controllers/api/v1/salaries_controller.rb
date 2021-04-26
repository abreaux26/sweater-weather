class Api::V1::SalariesController < ApplicationController
  before_action :invalid_destination?

  def index
    return render_error('Invalid destination.') if invalid_destination?

    forecast = ForecastFacade.get_forecast(params[:destination])

    salary_response = Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{params[:destination]}/salaries/")
    salary_data = JSON.parse(salary_response.body, symbolize_names: true)

    job_titles = ['Data Analyst',
                    'Data Scientist',
                    'Mobile Developer',
                    'QA Engineer',
                    'Software Engineer',
                    'Systems Administrator',
                    'Web Developer']

    jobs = salary_data[:salaries].find_all do |job_data|
      job_titles.include?(job_data[:job][:title])
    end
    binding.pry
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
