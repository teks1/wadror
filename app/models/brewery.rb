class Brewery < ActiveRecord::Base
	include RatingAverage

	validates :name, presence: true
	validates :year, numericality: { only_integer: true, greater_than: 1041 }
	validate :check_year_not_in_future

	scope :active, -> { where active:true }
	scope :retired, -> { where active:[nil,false] }

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def print_report
		puts self.name
		puts "established at year #{self.year}"
		puts "number of beers #{self.beers.count}"
	end

	def restart
    	self.year = 2016
    	puts "changed year to #{year}"
    end

    def check_year_not_in_future
    	if self.year.present? && Time.now.year < self.year
    		errors.add(:year, "can't be in the future")
    	end
    end

  	#def average_rating
  	#	"average #{ratings.average(:score)}"
  	#end
	
	def self.top(n)
   		sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }.first(n)
 	end

end
