class Beer < ActiveRecord::Base
	include RatingAverage

	validates :name, presence: true
	validates :style, presence: true

	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	has_many :raters, -> { uniq }, through: :ratings, source: :user

	#def average_rating
	#	byebug
	#	"average #{ratings.average(:score)}"
	#end

	def to_s
		"#{name} from #{brewery.name}"
	end

end
