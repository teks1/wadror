class Beer < ActiveRecord::Base
	include RatingAverage
	belongs_to :brewery
	has_many :ratings, dependent: :destroy

	#def average_rating
	#	"average #{ratings.average(:score)}"
	#end

	def to_s
		"#{name} from #{brewery.name}"
	end

end
