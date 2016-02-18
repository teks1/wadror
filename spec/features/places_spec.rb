require 'rails_helper'

include Helpers

describe "Places" do
	it "if one is returned by the API, it is shown at the page" do
    	allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      		[ Place.new( name:"Oljenkorsi", id: 1 ) ]
    	)

   		visit places_path
    	fill_in('city', with: 'kumpula')
    	click_button "Search"

    	expect(page).to have_content "Oljenkorsi"
  	end
  	it "if many are returned by the API, they are shown at the page" do
    	kumpula = "kumpula"
    	allow(BeermappingApi).to receive(:places_in).with(kumpula).and_return(
      		[ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Pub Pete", id: 2 ) ]
    	)

   		visit places_path
    	fill_in('city', with: 'kumpula')
    	click_button "Search"

    	expect(page).to have_content "Oljenkorsi" and "Pub Pete"
  	end
  	it "if none is returned by the API, they are shown at the page" do
    	kumpula = "kumpula"
    	allow(BeermappingApi).to receive(:places_in).with(kumpula).and_return(
      		[ ]
    	)

   		visit places_path
    	fill_in('city', with: 'kumpula')
    	click_button "Search"

    	expect(page).to have_content "No locations in #{kumpula}"
  	end

end