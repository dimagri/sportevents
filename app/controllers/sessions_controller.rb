class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_path, notice: 'Успешный вход'
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def failure
    redirect_to root_path, alert: 'Неудачный вход'
  end
end
