class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    # notice = user.email_confirmed? ? 'Успешный вход' : 'Успешный вход (настоятельно рекомендуем указать емейл в вашем профиле)'
    notice = if user.email_confirmed?
               'Успешный вход'
             elsif user.email.present?
               'Успешный вход. Настоятельно рекомендуем подтвердить свой адрес электронной почты'
             else
               'Успешный вход (настоятельно рекомендуем указать емейл в вашем профиле)'
             end
    redirect_to root_path, notice: notice
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def failure
    redirect_to root_path, alert: 'Неудачный вход'
  end
end
