require 'rails_helper'

RSpec.describe SalariesFacade do
  describe "class methods" do
    it "::get_salaries" do
      forecast = ForecastFacade.get_forecast('chicago')
      salaries_info = SalariesFacade.get_salaries('chicago', forecast)
      expect(salaries_info).to be_instance_of(Salary)
      expect(salaries_info.destination).to eq('chicago')
      expect(salaries_info.forecast).to be_a(Hash)
      expect(salaries_info.salaries).to be_an(Array)
    end

    it '::get_specific_jobs(all_job_salaries)' do
      salary_data = UrbanAreaService.get_data('chicago')
      specific_jobs = SalariesFacade.get_specific_jobs(salary_data[:salaries])

      expect(specific_jobs).to be_an(Array)
      expect(specific_jobs.first).to be_a(Hash)
    end

    it '::salary_data(destination, forecast, jobs)' do
      forecast = ForecastFacade.get_forecast('chicago')
      data = UrbanAreaService.get_data('chicago')
      specific_jobs = SalariesFacade.get_specific_jobs(data[:salaries])
      salary_data = SalariesFacade.salary_data('chicago', forecast, specific_jobs)

      expect(salary_data).to be_a(Hash)
      expect(salary_data).to have_key(:destination)
      expect(salary_data).to have_key(:forecast)
      expect(salary_data).to have_key(:salaries)

      expect(salary_data[:destination]).to be_a(String)
      expect(salary_data[:forecast]).to be_a(Hash)
      expect(salary_data[:salaries]).to be_a(Array)
    end

    it '::salary_forecast(current_weather)' do
      forecast = ForecastFacade.get_forecast('chicago')
      salary_forecast = SalariesFacade.salary_forecast(forecast.current_weather)

      expect(salary_forecast).to be_a(Hash)
      expect(salary_forecast).to have_key(:summary)
      expect(salary_forecast).to have_key(:temperature)

      expect(salary_forecast[:summary]).to be_a(String)
      expect(salary_forecast[:temperature]).to be_a(String)
    end

    it '::salaries(jobs)' do
      data = UrbanAreaService.get_data('chicago')
      specific_jobs = SalariesFacade.get_specific_jobs(data[:salaries])
      salaries = SalariesFacade.salaries(specific_jobs)

      expect(salaries).to be_an(Array)

      salaries.each do |salary_info|
        expect(salary_info).to be_a(Hash)
        expect(salary_info).to have_key(:title)
        expect(salary_info).to have_key(:min)
        expect(salary_info).to have_key(:min)
      end
    end
  end
end
