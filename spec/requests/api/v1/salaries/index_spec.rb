require 'rails_helper'
RSpec.describe 'Salaries' do
  before :each do
  end

  describe 'happy path' do
    it 'salary info' do
      get '/api/v1/salaries?destination=chicago'

      expect(response).to be_successful

      salary = JSON.parse(response.body, symbolize_names: true)

      expect(salary[:data][:attributes].count).to eq(3)

      expect(salary[:data]).to have_key(:id)
      expect(salary[:data]).to have_key(:type)
      expect(salary[:data][:attributes]).to have_key(:destination)
      expect(salary[:data][:attributes]).to have_key(:forecast)
      expect(salary[:data][:attributes]).to have_key(:salaries)

      expect(salary[:data][:id]).to be_nil
      expect(salary[:data][:type]).to eq('salaries')

      expect(salary[:data][:attributes][:forecast]).to be_a(Hash)
      expect(salary[:data][:attributes][:salaries]).to be_an(Array)
    end
  end

  describe 'sad path' do
    it 'returns error when no location is passed' do
      get '/api/v1/salaries?destination='

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:error]).to eq('Invalid destination.')
    end

    it 'returns error when no location param' do
      get '/api/v1/salaries'

      expect(response).not_to be_successful
      expect(response.status).to eq(400)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:error]).to eq('Invalid destination.')
    end
  end
end
