class SalariesFacade
  def self.get_salaries(destination, forecast)
    salary_response = Faraday.get("https://api.teleport.org/api/urban_areas/slug:#{destination}/salaries/")
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

    {
      destination: destination,
      forecast: salary_forecast(forecast.current_weather),
      salaries: salary_info(jobs)
    }
  end

  private
  def self.salary_forecast(current_weather)
    {
      summary: current_weather.conditions,
      temperature: "#{current_weather.temperature.to_i} F"
    }
  end

  def self.salary_info(jobs)
    jobs.map do |data|
      {
        title: data[:job][:title],
        min: ActiveSupport::NumberHelper.number_to_currency(data[:salary_percentiles][:percentile_25]),
        max: ActiveSupport::NumberHelper.number_to_currency(data[:salary_percentiles][:percentile_75])
      }
    end
  end
end
