require 'rails_helper'
RSpec.describe 'Background Image' do
  describe 'happy path' do
    it 'gets background image' do
      VCR.use_cassette('background_image') do
        get '/api/v1/backgrounds?location=denver,co'

        expect(response).to be_successful

        background = JSON.parse(response.body, symbolize_names: true)

        expect(background[:data][:attributes].count).to eq(1)

        expect(background[:data]).to have_key(:id)
        expect(background[:data]).to have_key(:type)
        expect(background[:data][:attributes]).to have_key(:image)

        expect(background[:data][:id]).to be_nil
        expect(background[:data][:type]).to eq('image')

        expect(background[:data][:attributes].size).to eq(1)

        expect(background[:data][:attributes][:image]).to have_key(:location)
        expect(background[:data][:attributes][:image]).to have_key(:image_url)
        expect(background[:data][:attributes][:image]).to have_key(:credits)
        expect(background[:data][:attributes][:image][:credits]).to have_key(:source)
        expect(background[:data][:attributes][:image][:credits]).to have_key(:photographer)
        expect(background[:data][:attributes][:image][:credits]).to have_key(:photographer_url)
        expect(background[:data][:attributes][:image][:credits]).to have_key(:logo)

        expect(background[:data][:attributes][:image][:location]).to be_a(String)
        expect(background[:data][:attributes][:image][:image_url]).to be_a(String)
        expect(background[:data][:attributes][:image][:credits]).to be_a(Hash)
        expect(background[:data][:attributes][:image][:credits][:source]).to be_a(String)
        expect(background[:data][:attributes][:image][:credits][:photographer]).to be_a(String)
        expect(background[:data][:attributes][:image][:credits][:photographer_url]).to be_a(String)
        expect(background[:data][:attributes][:image][:credits][:logo]).to be_a(String)
      end
    end
  end

  describe 'sad path' do
    it 'returns error when no location is passed' do
      get '/api/v1/backgrounds?location='

      expect(response).not_to be_successful
      expect(response.status).to eq(406)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:error]).to eq('Invalid location.')
    end

    it 'returns error when no location param' do
      get '/api/v1/backgrounds'

      expect(response).not_to be_successful
      expect(response.status).to eq(406)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:error]).to eq('Invalid location.')
    end
  end
end
