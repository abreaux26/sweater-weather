class Api::V1::SalariesController < ApplicationController
  include ActionView::Helpers::NumberHelper
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

    salary_info = {
      destination: params[:destination],
      forecast: salary_forecast(forecast.current_weather),
      salaries: salary_info(jobs)
    }

    render json: SalariesSerializer.new(Salary.new(salary_info))
  end

  private
  def salary_forecast(current_weather)
    {
      summary: current_weather.conditions,
      temperature: "#{current_weather.temperature.to_i} F"
    }
  end

  def salary_info(jobs)
    jobs.map do |data|
      {
        title: data[:job][:title],
        min: number_to_currency(data[:salary_percentiles][:percentile_25]),
        max: number_to_currency(data[:salary_percentiles][:percentile_75])
      }
    end
  end
end
