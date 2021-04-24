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

        expect(forecast[:data][:id]).to be_nil
        expect(forecast[:data][:type]).to eq('image')
      end
    end
  end

  describe 'sad path' do
  end
end
