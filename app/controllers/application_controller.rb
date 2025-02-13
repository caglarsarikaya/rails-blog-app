class ApplicationController < ActionController::Base
  include Pundit::Authorization
  
  # Prevent CSRF attacks by raising an exception
  protect_from_forgery with: :exception
  
  # Configure Pundit's user
  def pundit_user
    current_user
  end

  # Handle Pundit authorization errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
end
