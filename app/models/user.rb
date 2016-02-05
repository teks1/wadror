class User < ActiveRecord::Base
	include RatingAverage

	has_secure_password

	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, format: { with: /\A[a-z]+[A-Z]+[0-9]+\z{4,}/, message: "must be at least 4 characters
	 and contain at least one small letter, one capital letter and one number" }

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :beer_clubs, -> { uniq }, through: :memberships
	has_many :memberships, dependent: :destroy

end
