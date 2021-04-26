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

      expect(salary[:data][:attributes][:destination]).to be_a(String)
      expect(salary[:data][:attributes][:forecast]).to be_a(Hash)
      expect(salary[:data][:attributes][:salaries]).to be_an(Array)

      test_forecast(salary[:data][:attributes][:forecast])
      test_salaries(salary[:data][:attributes][:salaries])
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

  def test_forecast(forecast)
    expect(forecast).to have_key(:summary)
    expect(forecast).to have_key(:temperature)

    expect(forecast[:summary]).to be_a(String)
    expect(forecast[:temperature]).to be_a(String)
  end

  def test_salaries(salaries)
    salaries.each do |data|
      expect(data).to be_a(Hash)
      expect(data).to have_key(:title)
      expect(data).to have_key(:min)
      expect(data).to have_key(:max)

      expect(data[:title]).to be_a(String)
      expect(data[:min]).to be_a(String)
      expect(data[:max]).to be_a(String)
    end
  end
end
