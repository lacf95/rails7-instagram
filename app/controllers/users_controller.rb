class UsersController < ApplicationController
  before_action :validates_user_session

  def index
    @users = User.where(name: search_param).or(User.where(email: search_param))
  end

  def show
    user
  end

  def follow
    return head 404 unless current_user.can_follow? user

    current_user.followeds << user
    current_user.save
    redirect_to action: :show, id: user.id
  end

  def unfollow
    return head 404 unless current_user.can_unfollow? user

    current_user.followeds_relationships.find_by!(followed_id: user.id).destroy
    redirect_to action: :show, id: user.id
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def search_param
    params[:search]
  end
end
