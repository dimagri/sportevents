module UsersHelper
  def user_can_add_to_friends
    current_user.present? && current_user.id != @user.id && current_user.friends.where(id: @user.id).empty?
  end

  def user_can_remove_from_friends
    current_user.friends.where(id: @user.id).first
    current_user.present? && !current_user.friends.where(id: @user.id).empty?

  end
end
