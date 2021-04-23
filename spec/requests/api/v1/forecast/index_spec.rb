require 'rails_helper'
RSpec.describe 'Retrieving weather for a city' do
  before :each do
  end

  describe 'happy path' do
    it 'gets current_weather' do
      # VCR.use_cassette('forecast/location') do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful

        current_weather = JSON.parse(response.body, symbolize_names: true)

        expect(current_weather[:data][:attributes].count).to eq(10)

        current_weather[:data].each do |data|
          expect(data).to have_key(:id)
          expect(data).to have_key(:type)
          expect(data[:attributes]).to have_key(:datetime)
          expect(data[:attributes]).to have_key(:sunrise)
          expect(data[:attributes]).to have_key(:sunset)
          expect(data[:attributes]).to have_key(:temperature)
          expect(data[:attributes]).to have_key(:feels_like)
          expect(data[:attributes]).to have_key(:humidity)
          expect(data[:attributes]).to have_key(:uvi)
          expect(data[:attributes]).to have_key(:visibility)
          expect(data[:attributes]).to have_key(:conditions)
          expect(data[:attributes]).to have_key(:icon)

          expect(data[:id].to_i).to be_nil
          expect(data[:type]).to eq('forecast')
          expect(data[:attributes][:datetime]).to be_a(String)
          expect(data[:attributes][:sunrise]).to be_a(String)
          expect(data[:attributes][:sunset].to_f).to be_a(String)
          expect(data[:attributes][:temperature]).to be_a(Float)
          expect(data[:attributes][:feels_like]).to be_a(Float)
          expect(data[:attributes][:humidity]).to be_a(Float)
          expect(data[:attributes][:uvi]).to be_a(Float)
          expect(data[:attributes][:visibility]).to be_a(Float)
          expect(data[:attributes][:conditions]).to be_a(String)
          expect(data[:attributes][:icon]).to be_a(String)
        end
      # end
    end
  end

  describe 'sad path' do
  end
end
