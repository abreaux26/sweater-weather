require 'rails_helper'

RSpec.describe Background do
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
  end

  it 'can be created' do
    expect(@background.class).to eq(Background)
  end

  it 'has valid attributes' do
    expect(@background.location).to eq("downtown denver, co")
    expect(@background.image_url).to eq("https://www.pexels.com/photo/red-and-white-concrete-building-during-night-time-3751010/")
    expect(@background.credits).to be_a(Hash)
    expect(@background.credits).to have_key(:source)
    expect(@background.credits).to have_key(:photographer)
    expect(@background.credits).to have_key(:photographer_url)
    expect(@background.credits).to have_key(:logo)
    expect(@background.credits[:source]).to eq('https://www.pexels.com')
    expect(@background.credits[:photographer]).to eq('Photo by Colin Lloyd on Pexels')
    expect(@background.credits[:photographer_url]).to eq('https://www.pexels.com/@colin-lloyd-2120291')
    expect(@background.credits[:logo]).to eq('https://images.pexels.com/lib/api/pexels.png')
  end

  it 'get_credits(data)' do
    credits = @background.get_credits(@data)
    expect(credits).to be_a(Hash)
    expect(credits[:source]).to eq('https://www.pexels.com')
    expect(credits[:photographer]).to eq('Photo by Colin Lloyd on Pexels')
    expect(credits[:photographer_url]).to eq('https://www.pexels.com/@colin-lloyd-2120291')
    expect(credits[:logo]).to eq('https://images.pexels.com/lib/api/pexels.png')
  end
end
