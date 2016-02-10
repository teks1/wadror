FactoryGirl.define do 
	factory :user do
		username "Pekka"
		password "Foobar1"
		password_confirmation "Foobar1"
	end
	factory :user2, class: User do
		username "Arto"
		password "Aaa1"
		password_confirmation "Aaa1"
	end
	factory :rating do
		score 10
		beer
		user
	end
	factory :rating2, class: Rating do 
		score 20
	end
	factory :rating3, class: Rating do 
		score 10
	end
	factory :brewery do
    	name "Brewery"
    	year 1900
  	end

 	factory :beer do
    	name "Beer"
    	brewery
    	style "Lager"
  	end

end