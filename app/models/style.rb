class Style < ActiveRecord::Base
	include RatingAverage

	validates :name, presence: true

	has_many :beers
	has_many :ratings, through: :beers

	def self.top(n)
   		sorted_by_rating_in_desc_order = Style.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
 	end

end
