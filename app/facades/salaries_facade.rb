class SalariesFacade
  def self.get_salaries(destination, forecast)
    data = UrbanAreaService.get_data(destination)
    jobs = get_specific_jobs(data[:salaries])
    Salary.new(salary_data(destination, forecast, jobs))
  end

  def self.get_specific_jobs(all_job_salaries)
    all_job_salaries.find_all do |job_data|
      job_titles.include?(job_data[:job][:title])
    end
  end

  def self.salary_data(destination, forecast, jobs)
    {
      destination: destination,
      forecast: salary_forecast(forecast.current_weather),
      salaries: salaries(jobs)
    }
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

  private

  def self.job_titles
    [
      'Data Analyst',
      'Data Scientist',
      'Mobile Developer',
      'QA Engineer',
      'Software Engineer',
      'Systems Administrator',
      'Web Developer'
    ]
  end
end
