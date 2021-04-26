require 'rails_helper'

RSpec.describe SalariesFacade do
  describe "class methods" do
    it "::get_salaries" do
        salaries_info = SalariesFacade.get_salaries('chicago')
        expect(salaries_info).to be_instance_of(Salary)
        expect(salaries_info.destination).to eq('chicago')
        expect(salaries_info.forecast).to be_a(Hash)
        expect(salaries_info.salaries).to be_an(Array)
    end
  end
end
