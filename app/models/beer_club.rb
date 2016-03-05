class BeerClub < ActiveRecord::Base
	
	has_many :members, -> { uniq }, through: :memberships, source: :user
	has_many :memberships, dependent: :destroy
	has_many :memberships, -> { where confirmed: true}

end
