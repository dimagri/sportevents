class FriendshipsController < ApplicationController

  before_action :check_current_user

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = 'Пользователь был добавлен в друзья'
      redirect_to :back
    else
      flash[:notice] = 'Пользователь не был добавлен в друзья'
      redirect_to :back
    end
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:friend_id])
    @friendship.destroy_all
    flash[:notice] = 'Пользователь был удалён из друзей'
    redirect_to :back
  end

  private

  def check_current_user
    redirect_to :back, alert: 'Сначала зарегистрируйтесь' unless current_user.present?
    if !current_user.present?
        redirect_to :back, alert: 'Сначала зарегистрируйтесь'
    elsif current_user.id == params[:friend_id] || !current_user.friends.where(id: params[:friends_id]).empty?
        redirect_to :back
    end
  end

end
