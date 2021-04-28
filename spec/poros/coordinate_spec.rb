require 'rails_helper'

RSpec.describe Coordinate do
  before :each do
    @data = {:lat=>39.738453, :lng=>-104.984853}

    @coordinate = Coordinate.new(@data)
  end

  it 'can be created' do
    expect(@coordinate.class).to eq(Coordinate)
  end

  it 'has valid attributes' do
    expect(@coordinate.lat).to eq(39.738453)
    expect(@coordinate.lng).to eq(-104.984853)
  end
end
