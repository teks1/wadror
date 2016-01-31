module RatingAverage

	extend ActiveSupport::Concern
	
	def average_rating
		"average #{ratings.average(:score)}"
	end

end