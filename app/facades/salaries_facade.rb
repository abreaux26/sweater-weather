class SalariesFacade
  def self.get_salaries(destination, forecast)
    salary_data = UrbanAreaService.get_data(destination)

    job_titles = ['Data Analyst',
                    'Data Scientist',
                    'Mobile Developer',
                    'QA Engineer',
                    'Software Engineer',
                    'Systems Administrator',
                    'Web Developer']

    jobs = get_jobs(salary_data[:salaries], job_titles)
    salary_data(destination, forecast, jobs)
  end

  private

  def self.get_jobs(all_salaries, job_titles)
    all_salaries.find_all do |job_data|
      job_titles.include?(job_data[:job][:title])
    end
  end

  def self.salary_forecast(current_weather)
    {
      summary: current_weather.conditions,
      temperature: "#{current_weather.temperature.to_i} F"
    }
  end

  def self.salaries(jobs)
    jobs.map do |data|
      {
        title: data[:job][:title],
        min: ActiveSupport::NumberHelper.number_to_currency(data[:salary_percentiles][:percentile_25]),
        max: ActiveSupport::NumberHelper.number_to_currency(data[:salary_percentiles][:percentile_75])
      }
    end
  end

  def self.salary_data(destination, forecast, jobs)
    {
      destination: destination,
      forecast: salary_forecast(forecast.current_weather),
      salaries: salaries(jobs)
    }
  end
end
