module ApplicationHelper

  def current_user
    @current_user ||= User.where(id: session[:user_id]).first if session[:user_id].present?
  end

end
