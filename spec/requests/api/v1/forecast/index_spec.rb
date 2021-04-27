require 'rails_helper'
RSpec.describe 'Retrieving weather for a city' do
  describe 'happy path' do
    it 'gets forecast' do
      VCR.use_cassette('forecast') do
        get '/api/v1/forecast?location=denver,co'

        expect(response).to be_successful

        forecast = JSON.parse(response.body, symbolize_names: true)

        expect(forecast[:data][:attributes].count).to eq(3)

        expect(forecast[:data]).to have_key(:id)
        expect(forecast[:data]).to have_key(:type)
        expect(forecast[:data][:attributes]).to have_key(:current_weather)
        expect(forecast[:data][:attributes]).to have_key(:daily_weather)
        expect(forecast[:data][:attributes]).to have_key(:hourly_weather)

        expect(forecast[:data][:id]).to be_nil
        expect(forecast[:data][:type]).to eq('forecast')

        current_weather_test(forecast[:data][:attributes][:current_weather])
        daily_weather_test(forecast[:data][:attributes][:daily_weather])
        hourly_weather_test(forecast[:data][:attributes][:hourly_weather])
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

    it 'returns error when number is passed' do
      get '/api/v1/forecast?location=123'
      
      expect(response).not_to be_successful
      expect(response.status).to eq(406)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:error]).to eq('Invalid location.')
    end
  end

  def current_weather_test(data)
    expect(data).to be_a(Hash)

    expect(data).to have_key(:datetime)
    expect(data).to have_key(:sunrise)
    expect(data).to have_key(:sunset)
    expect(data).to have_key(:temperature)
    expect(data).to have_key(:feels_like)
    expect(data).to have_key(:humidity)
    expect(data).to have_key(:uvi)
    expect(data).to have_key(:visibility)
    expect(data).to have_key(:conditions)
    expect(data).to have_key(:icon)

    expect(data).not_to have_key(:pressure)
    expect(data).not_to have_key(:dew_point)
    expect(data).not_to have_key(:clouds)
    expect(data).not_to have_key(:wind_speed)
    expect(data).not_to have_key(:wind_deg)

    expect(data[:datetime]).to be_a(String)
    expect(data[:sunrise]).to be_a(String)
    expect(data[:sunset]).to be_a(String)
    expect(data[:temperature]).to be_a(Float)
    expect(data[:feels_like]).to be_a(Float)
    expect(data[:humidity]).to be_a(Float).or be_a(Integer)
    expect(data[:uvi]).to be_a(Float).or be_a(Integer)
    expect(data[:visibility]).to be_a(Float).or be_a(Integer)
    expect(data[:conditions]).to be_a(String)
    expect(data[:icon]).to be_a(String)
  end

  def daily_weather_test(daily_data)
    expect(daily_data).to be_an(Array)
    expect(daily_data.count).to eq(5)

    daily_data.each do |data|
      expect(data).to be_a(Hash)

      expect(data).to have_key(:date)
      expect(data).to have_key(:sunrise)
      expect(data).to have_key(:sunset)
      expect(data).to have_key(:max_temp)
      expect(data).to have_key(:min_temp)
      expect(data).to have_key(:conditions)
      expect(data).to have_key(:icon)

      expect(data).not_to have_key(:moonrise)
      expect(data).not_to have_key(:moonset)
      expect(data).not_to have_key(:moon_phase)
      expect(data).not_to have_key(:feels_like)
      expect(data).not_to have_key(:pressure)
      expect(data).not_to have_key(:humidity)
      expect(data).not_to have_key(:dew_point)
      expect(data).not_to have_key(:wind_speed)
      expect(data).not_to have_key(:wind_deg)
      expect(data).not_to have_key(:wind_gust)
      expect(data).not_to have_key(:clouds)
      expect(data).not_to have_key(:pop)
      expect(data).not_to have_key(:uvi)

      expect(data[:date]).to be_a(String)
      expect(data[:sunrise]).to be_a(String)
      expect(data[:sunset]).to be_a(String)
      expect(data[:max_temp]).to be_a(Float)
      expect(data[:min_temp]).to be_a(Float)
      expect(data[:conditions]).to be_a(String)
      expect(data[:icon]).to be_a(String)
    end
  end

  def hourly_weather_test(hourly_data)
    expect(hourly_data).to be_an(Array)
    expect(hourly_data.count).to eq(8)

    hourly_data.each do |data|
      expect(data).to be_a(Hash)

      expect(data).to have_key(:time)
      expect(data).to have_key(:temperature)
      expect(data).to have_key(:conditions)
      expect(data).to have_key(:icon)

      expect(data).not_to have_key(:feels_like)
      expect(data).not_to have_key(:pressure)
      expect(data).not_to have_key(:humidity)
      expect(data).not_to have_key(:dew_point)
      expect(data).not_to have_key(:uvi)
      expect(data).not_to have_key(:clouds)
      expect(data).not_to have_key(:visibility)
      expect(data).not_to have_key(:wind_speed)
      expect(data).not_to have_key(:wind_deg)
      expect(data).not_to have_key(:wind_gust)
      expect(data).not_to have_key(:pop)

      expect(data[:time]).to be_a(String)
      expect(data[:temperature]).to be_a(Float)
      expect(data[:conditions]).to be_a(String)
      expect(data[:icon]).to be_a(String)
    end
  end
end
