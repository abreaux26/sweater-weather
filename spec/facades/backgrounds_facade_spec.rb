require 'rails_helper'

RSpec.describe BackgroundsFacade do
  describe "class methods" do
    it "::get_background" do
      VCR.use_cassette('facade/get_background') do
        background_image = BackgroundsFacade.get_background('denver,co')
        expect(background_image).to be_instance_of(Image)
        expect(background_image.image).to be_instance_of(Background)
      end
    end
  end
end
