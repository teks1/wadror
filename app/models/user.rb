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
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(category)
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.send(category) }.uniq
    rated.sort_by { |item| -rating_of(category, item) }.first
  end

  private

  def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

  def self.top(n)
      sorted_by_rating_count_in_desc_order = User.all.sort_by{ |u| -(u.ratings.count || 0) }.first(n)
  end
end
