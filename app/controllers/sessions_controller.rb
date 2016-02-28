class SessionsController < ApplicationController
	def new

	end

	def create
		user = User.find_by username: params[:username]
		if user && user.authenticate(params[:password])
			if user.banned?
				return redirect_to :back, notice: "Your account is forzen, contact admin"
			end

			session[:user_id] = user.id
			redirect_to user, notice: "Welcome back"
		else
			redirect_to :back, notice: "User #{params[:username]} does not exist and/or password is wrong"
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to :root
	end
end
