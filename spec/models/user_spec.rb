require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
	
  it "has username set correctly" do
  	user = User.new username:"Pekka"

  	#user.username.should == "Pekka"
  	expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
  	user = User.create username:"Pekka"

  	expect(user.valid?).to be(false)
  	expect(user).not_to be_valid
  	expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating3)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "password too short or doesn't include number" do
  	userA = User.create username:"Pekka", password:"Aa1", password_confirmation:"Aa1"
  	userB = User.create username:"Arto", password:"AaAaAa", password_confirmation:"AaAaAa"
  		
  	expect(userA.valid?).to be(false)
  	expect(userB.valid?).to be(false)
  	expect(User.count).to eq(0)
  end
  
   describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end
     it "is the one with highest rating if several rated" do
      brewery = FactoryGirl.create(:brewery)
      lager = FactoryGirl.create(:style)
      create_beers_with_ratings(user, lager, brewery, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, lager, brewery, 25)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the style of the only rated if only one rating" do
      lager = FactoryGirl.create(:style)
      beer = FactoryGirl.create(:beer, style: lager)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_style.name).to eq("Lager")
    end

    it "is the style with highest average score if several rated" do
      brewery = FactoryGirl.create(:brewery)
      lager = FactoryGirl.create(:style)
      ipa = FactoryGirl.create(:style, name: "ipa")
      stout = FactoryGirl.create(:style, name: "stout")
      create_beers_with_ratings(user, lager, brewery, 10, 20, 15, 7, 9)
      create_beers_with_ratings(user, ipa, brewery, 25, 20)
      create_beers_with_ratings(user, stout, brewery, 20, 23, 22)

      expect(user.favorite_style.name).to eq("ipa")
    end
  end
	describe "favorite brewery" do
    	let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the brewery of the only rated if only one rating" do
      brewery = FactoryGirl.create(:brewery)
      lager = FactoryGirl.create(:style)
      beer = FactoryGirl.create(:beer, style: lager, brewery: brewery )
      FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_brewery).to eq(brewery)
    end

    it "is the brewery with highest average score if several rated" do
      brewery1 = FactoryGirl.create(:brewery)
      brewery2 = FactoryGirl.create(:brewery)
      brewery3 = FactoryGirl.create(:brewery)
      lager = FactoryGirl.create(:style)
      ipa = FactoryGirl.create(:style, name: "ipa")
      stout = FactoryGirl.create(:style, name: "stout")
      create_beers_with_ratings(user, lager, brewery1, 10, 20, 15, 7, 9)
      create_beers_with_ratings(user, ipa, brewery2, 25, 20)
      create_beers_with_ratings(user, stout, brewery3, 20, 23, 22)

      expect(user.favorite_brewery).to eq(brewery2)
    end
  end
end
