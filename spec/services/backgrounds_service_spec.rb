require 'rails_helper'
RSpec.describe 'Backgrounds Service' do
  describe 'happy path' do
    it '::get_background(location)' do
      VCR.use_cassette('background_service/get_background') do
        background = BackgroundsService.get_background('denver,co')

        expect(background).to be_a(Hash)
        expect(background).to have_key(:url)
        expect(background).to have_key(:photographer)
        expect(background).to have_key(:photographer_url)
      end
    end
  end

  describe 'sad path' do
    it 'no location is passed'
  end
end
