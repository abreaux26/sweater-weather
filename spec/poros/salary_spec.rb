require 'rails_helper'

RSpec.describe Salary do
  before :each do
    @salary = Salary.new(
      {
        destination: "chicago",
        forecast: { summary: "cloudy", temperature: '89 F' },
        salaries: [{title: 'Data Analyst', min: '$2,000.00', max: '$5,000.00'}]
      })
  end

  it 'can be created' do
    expect(@salary).to be_instance_of(Salary)
  end

  it 'has valid attributes' do
    expect(@salary.destination).to eq("chicago")
    expect(@salary.forecast).to be_a(Hash)
    expect(@salary.forecast).to eq({ summary: "cloudy", temperature: '89 F' })
    expect(@salary.salaries).to be_an(Array)
    expect(@salary.salaries).to eq([{title: 'Data Analyst', min: '$2,000.00', max: '$5,000.00'}])
  end
end
