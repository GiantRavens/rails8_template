class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
#   helper_method :current_user, :logged_in?
# 
#   # returns the current logged-in user, if there is one
#   def current_user
#     @current_user ||= User.find(session[:user_id]) if session[:user_id]
#   end
# 
#   # checks if the user is logged in
#   def logged_in?
#     current_user.present?
#   end

  # redirects to login page if user is not logged in
  # def require_login
  #   unless logged_in?
  #     flash[:alert] = "You must be logged in to access this page."
  #     redirect_to login_path
  #   end
  # end
 
end
