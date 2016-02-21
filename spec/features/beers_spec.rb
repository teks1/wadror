require 'rails_helper'

include Helpers

describe "Beer" do
	let!(:user) { FactoryGirl.create :user }
	let!(:brewery) { FactoryGirl.create :brewery, name:'Koff' }
	let!(:style) { FactoryGirl.create :style }
	
	before :each do
		sign_in(username:"Pekka", password:"Foobar1")
	end

	it "create new beer with valid name" do
		visit new_beer_path
		fill_in('beer_name', with:'Koff')

		click_button('Create Beer')

		expect(current_path).to eq(beers_path)
		expect(Beer.count).to eq(1)
		
	end
	it "create new beer with empty name" do
		visit new_beer_path
		fill_in('beer_name', with:'')
		expect{click_button('Create Beer')}.to change {Beer.count}.by(0)
		expect(page).to have_content("Name can't be blank")

	end

end