class User < ActiveRecord::Base
	include RatingAverage

	has_secure_password

	validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
	validates :password, length: { minimum: 4 },
                       format: {
                          with: /\d.*[A-Z]|[A-Z].*\d/,
                          message: "has to contain one number and one upper case letter"
                       }

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings
	has_many :beer_clubs, -> { uniq }, through: :memberships
	has_many :memberships, dependent: :destroy

	def favorite_beer
		return nil if ratings.empty?
		ratings.order("score DESC").limit(1).first.beer
  	end
  	
  	def favorite_style
  		return nil if ratings.empty?
  		ratings.select("score, beer_id").limit(1).first.beer.style
  	end
  	
  	def favorite_brewery
  		return nil if ratings.empty?
  	end
end
