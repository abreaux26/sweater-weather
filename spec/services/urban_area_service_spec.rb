require 'rails_helper'
RSpec.describe 'Urban Area Service' do
  describe 'happy path' do
    it '::salary_info(destination)' do
      salary_info = UrbanAreaService.get_data('chicago')

      expect(salary_info).to be_a(Hash)
      expect(salary_info).to have_key(:salaries)
      expect(salary_info[:salaries].first).to have_key(:job)
      expect(salary_info[:salaries].first[:job]).to have_key(:title)
      expect(salary_info[:salaries].first[:salary_percentiles]).to have_key(:percentile_25)
      expect(salary_info[:salaries].first[:salary_percentiles]).to have_key(:percentile_75)
    end
  end

  describe 'sad path' do
  end
end
