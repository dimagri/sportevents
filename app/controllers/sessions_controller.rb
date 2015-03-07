class SessionsController < ApplicationController

  def login_with_email
    @user = User.find_by_email(params[:email].downcase)
    create_session(@user)
  end

  def login_with_oauth
    auth = request.env['omniauth.auth']
    @user = User.from_omniauth(auth)
    create_session(@user)
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def failure
    redirect_to root_path, alert: 'Неудачный вход'
  end

  def create_session(user)
    session[:user_id] = user.id
    notice = if user.email_confirmed?
               'Успешный вход'
             elsif user.email.present?
               'Успешный вход. Рекомендуем подтвердить свой адрес электронной почты'
             else
               'Успешный вход Рекомендуем указать емейл в вашем профиле'
             end
    redirect_to root_path, notice: notice
  end
end
