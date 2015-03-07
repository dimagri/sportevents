class UsersController < ApplicationController

  # TODO Add json

  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :check_user, only: [ :edit ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        @user.send_email_confirmation(params[:user][:email])
        format.html { redirect_to root_path, notice: 'На вашу почту отправлено письмо с подтверждением' }
      else
        format.html { render :new }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if params[:user][:email].present? && params[:user][:email] != @user.email
      @user.send_email_confirmation(params[:user][:email])
      notice = 'Профиль успешно изменён. На вашу почту отправлено письмо с подтверждением'
    else
      notice = 'Профиль успешно изменён.'
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: notice }
      else
        format.html { render :edit }
      end
    end
  end

  def send_email_confirmation
    @user = User.find(params[:user_id])
    @user.send_email_confirmation(@user.email)
    redirect_to @user, notice: 'На вашу почту повторно отправлено письмо с подтверждением'
  end

  def confirm_email
    @confirmation = Confirmation.where(email: params[:email]).last
    @user = User.find(@confirmation.user_id)
      if @confirmation.code == params[:code]
        @user.update_attributes(email: @confirmation.email, email_confirmed: true)
        @confirmation.destroy
        redirect_to @user, notice: 'Адрес электронной почты был подтверджён.'
      else
        redirect_to @user, notice: 'Возникла ошибка.'
      end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_user
    redirect_to @user, alert: 'У вас не прав на изменение этого профиля' unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :full_name, :email, :about, :phone, :skype, :avatar_url)
  end

end
