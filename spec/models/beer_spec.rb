require 'rails_helper'

RSpec.describe Beer, type: :model do
  
	it "creation with name and style works" do
		beer = Beer.create name:"Koff", style:"Lager"

		expect(beer.valid?).to be(true)
		expect(Beer.count).to eq(1)
	end

	it "creation doesn't work without name or style" do
		beerA = Beer.create name:"", style:"Lager"
		beerB = Beer.create name:"Koff", style:""

		expect(beerA).not_to be_valid
		expect(beerB).not_to be_valid
		expect(Beer.count).to eq(0)
	end
end
