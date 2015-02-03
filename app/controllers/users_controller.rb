class UsersController < ApplicationController

  # TODO Add json

  before_action :set_user, only: [ :show, :edit, :update ]
  before_action :check_user, only: [ :edit ]

  # GET /user/:id
  def show
  end

  # GET /users/:id/edit
  def edit
  end

  # PATCH/PUT /users/:id
  def update
    if params[:user][:email].present?
      @user.confirm_email(params[:user][:email])
      notice = 'Профиль успешно изменён. На вашу почту отправлено письмо с подтверждением.'
    else
      @user.update_attributes(email: '')
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

  def confirm_email
    @confirmation = Confirmation.find_by_email(params[:email])
    @user = User.find(@confirmation.user_id)
      if @confirmation.code == params[:code]
        @user.update_attributes(email: @confirmation.email)
        @confirmation.destroy
        redirect_to root_path, notice: 'Email был подтверджён.'
      else
        redirect_to root_path, notice: 'Возникла ошибка.'
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
    params.require(:user).permit(:name, :full_name, :about, :phone, :skype)
  end

end
