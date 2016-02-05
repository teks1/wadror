class BeerClub < ActiveRecord::Base
	
	has_many :users, -> { uniq }, through: :memberships
	has_many :memberships, dependent: :destroy

end
