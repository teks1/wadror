class PlacesController < ApplicationController

	

	def index
	end

	def show
		@place = BeermappingApi.fetch_one_place(params[:id])
		#byebug
  	end

	def search
		@places = BeermappingApi.places_in(params[:city])
    	if @places.empty?
      		redirect_to places_path, notice: "No locations in #{params[:city]}"
   		else
      		render :index
    	end
  	end

end