class Public::RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    if @user =! current_user
      redirect_to post_items_path
    end
    current_user.follow(params[:user_id])
    if current_user.released?
      @user.create_notification_follow!(current_user)
    end
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers
  end

end
