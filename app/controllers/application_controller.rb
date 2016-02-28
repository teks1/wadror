class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :admin_user

  def current_user
  	return nil if session[:user_id].nil?
  	User.find(session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin_user
    redirect_to :back, notice:'you are not admin' if !current_user.admin?
  end
  
  def admin_user
    return nil if session[:user_id].nil?
    current_user.admin
  end

end
