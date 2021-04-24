require 'rails_helper'
RSpec.describe 'Mapquest Service' do
  describe 'happy path' do
    it '::get_coordinates(location)' do
      VCR.use_cassette('mapquest_service/coordinates') do
        coords = MapquestService.get_coordinates('denver,co')

        expect(coords).to be_a(Hash)
        expect(coords).to have_key(:lat)
        expect(coords).to have_key(:lng)

        expect(coords[:lat]).to be_a(Float)
        expect(coords[:lng]).to be_a(Float)
      end
    end
  end

  describe 'sad path' do
  end
end
