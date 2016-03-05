class RatingsController < ApplicationController
	
	def index
		#Omissa testeissa ainoastaan top-oluiden cachauksella oli merkittava vaikutus
		@recent_ratings = Rating.recent
		Rails.cache.write("top breweries", Brewery.top(3), expires_in: 10.minutes) if Rails.cache.read("top breweries").nil?
		@top_breweries = Rails.cache.read("top breweries")
		Rails.cache.write("top beers", Beer.top(3), expires_in: 8.minutes) if Rails.cache.read("top beers").nil?
		@top_beers = Rails.cache.read("top beers")
		
		@top_styles = Style.top(3)
		
		@top_raters = User.top(3)
	end

	def new
		@rating = Rating.new
		@beers =Beer.all
	end

	def create
		@rating = Rating.new params.require(:rating).permit(:score, :beer_id)
		#session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
		if current_user.nil?
			redirect_to signin_path, notice: 'You should be signed in'
		elsif @rating.save
			current_user.ratings << @rating
			redirect_to current_user
		else
			@beers = Beer.all
			render :new
		end
	end

	def destroy
		rating = Rating.find(params[:id])
		rating.delete if current_user == rating.user
		redirect_to :back
	end

end
