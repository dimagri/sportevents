class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  helper_method :current_user

  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id].present?
  end

end
