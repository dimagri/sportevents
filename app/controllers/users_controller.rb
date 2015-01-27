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
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Профиль успешно изменён' }
      else
        format.html { render :edit }
      end
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
    params.require(:user).permit(:name, :full_name, :email, :about, :phone, :skype)
  end

end
