class Style < ActiveRecord::Base
	include RatingAverage

	validates :name, presence: true

	has_many :beers
	has_many :ratings, through: :beers

end
