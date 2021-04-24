require 'rails_helper'
RSpec.describe 'Retrieving weather for a city' do
  describe 'happy path' do
    it 'gets current_weather' do
      VCR.use_cassette('forecast/happy_path/current_weather') do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful

        current_weather = JSON.parse(response.body, symbolize_names: true)

        expect(current_weather[:data][:attributes].count).to eq(10)

        expect(current_weather[:data]).to have_key(:id)
        expect(current_weather[:data]).to have_key(:type)
        expect(current_weather[:data][:attributes]).to have_key(:datetime)
        expect(current_weather[:data][:attributes]).to have_key(:sunrise)
        expect(current_weather[:data][:attributes]).to have_key(:sunset)
        expect(current_weather[:data][:attributes]).to have_key(:temperature)
        expect(current_weather[:data][:attributes]).to have_key(:feels_like)
        expect(current_weather[:data][:attributes]).to have_key(:humidity)
        expect(current_weather[:data][:attributes]).to have_key(:uvi)
        expect(current_weather[:data][:attributes]).to have_key(:visibility)
        expect(current_weather[:data][:attributes]).to have_key(:conditions)
        expect(current_weather[:data][:attributes]).to have_key(:icon)

        expect(current_weather[:data][:attributes]).not_to have_key(:pressure)
        expect(current_weather[:data][:attributes]).not_to have_key(:dew_point)
        expect(current_weather[:data][:attributes]).not_to have_key(:clouds)
        expect(current_weather[:data][:attributes]).not_to have_key(:wind_speed)
        expect(current_weather[:data][:attributes]).not_to have_key(:wind_deg)

        expect(current_weather[:data][:id]).to be_nil
        expect(current_weather[:data][:type]).to eq('current_weather')
        expect(current_weather[:data][:attributes][:datetime]).to be_a(String)
        expect(current_weather[:data][:attributes][:sunrise]).to be_a(String)
        expect(current_weather[:data][:attributes][:sunset]).to be_a(String)
        expect(current_weather[:data][:attributes][:temperature]).to be_a(Float)
        expect(current_weather[:data][:attributes][:feels_like]).to be_a(Float)
        expect(current_weather[:data][:attributes][:humidity]).to be_a(Float).or be_a(Integer)
        expect(current_weather[:data][:attributes][:uvi]).to be_a(Float).or be_a(Integer)
        expect(current_weather[:data][:attributes][:visibility]).to be_a(Float).or be_a(Integer)
        expect(current_weather[:data][:attributes][:conditions]).to be_a(String)
        expect(current_weather[:data][:attributes][:icon]).to be_a(String)
      end
    end
  end

  describe 'sad path' do
    it 'returns error when no location is passed' do
      get '/api/v1/forecast?location='

      expect(response).not_to be_successful
      expect(response.status).to eq(406)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:error]).to eq('Invalid location.')
    end

    it 'returns error when no location param' do
      get '/api/v1/forecast'

      expect(response).not_to be_successful
      expect(response.status).to eq(406)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:error]).to eq('Invalid location.')
    end
  end
end
