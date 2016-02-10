require 'rails_helper'

include Helpers

describe "User" do
	let!(:user) { FactoryGirl.create :user }
	let!(:user2) { FactoryGirl.create :user2 }
	

	describe "who has signed up" do
		it "can signin with right credentials" do 
			sign_in(username:"Pekka", password:"Foobar1")

			expect(page).to have_content 'Welcome back'
      		expect(page).to have_content 'Pekka'

		end
		it "is redirected back to signin form if wrong credentials given" do
      		sign_in(username:"Pekka", password:"wrong")

      		expect(current_path).to eq(signin_path)

      		expect(page).to have_content "User Pekka does not exist and/or password is wrong"
    	end
    	it "when signed up with good credentials, is added to the system" do
    		visit signup_path

    		fill_in('user_username', with:'Brian')
    		fill_in('user_password', with:'Secret55')
    		fill_in('user_password_confirmation', with:'Secret55')

    		expect{click_button('Create User')}.to change{User.count}.by(1)
    	end
    	
	end
end

describe "User's page" do
	let!(:user) { FactoryGirl.create :user }
	let!(:user2) { FactoryGirl.create :user2 }

	before :each do
    	sign_in(username:"Pekka", password:"Foobar1")
    	FactoryGirl.create :rating, user:user
    	FactoryGirl.create :rating, score:15, user:user
    	FactoryGirl.create :rating, user:user2
    	visit user_path(user)
  	end

	it "has correct ratings" do
    	expect(user.ratings.count).to be(2)
    	expect(page).to have_content("Beer 10")
    	expect(page).to have_content("Beer 15")	
    end
    it "deleting rating" do

    	expect{first(:link, 'Delete').click}.to change{user.ratings.count}.by(-1)
    	
    end

end
