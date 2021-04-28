require 'rails_helper'

RSpec.describe Image do
  before :each do
    location = 'denver, co'
    @data = { :id=>3751010,
             :width=>3712,
             :height=>5568,
             :url=>"https://www.pexels.com/photo/red-and-white-concrete-building-during-night-time-3751010/",
             :photographer=>"Colin Lloyd",
             :photographer_url=>"https://www.pexels.com/@colin-lloyd-2120291",
             :photographer_id=>2120291,
             :avg_color=>"#5A4741",
             :src=>
              {:original=>"https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg",
               :large2x=>"https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
               :large=>"https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
               :medium=>"https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg?auto=compress&cs=tinysrgb&h=350",
               :small=>"https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg?auto=compress&cs=tinysrgb&h=130",
               :portrait=>"https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
               :landscape=>"https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
               :tiny=>"https://images.pexels.com/photos/3751010/pexels-photo-3751010.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"}}

    @background = Background.new(location, @data)

    @image = Image.new(@background)
  end

  it 'can be created' do
    expect(@image.class).to eq(Image)
  end

  it 'has valid attributes' do
    expect(@image.image).to be_instance_of(Background)
  end
end
