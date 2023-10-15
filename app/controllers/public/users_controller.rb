class Public::UsersController < ApplicationController
  before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @post_items = @user.post_items
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to post_items_path
  end

  def confirm
    @user = current_user
  end

  def favorites
    favorites = Favorite.order('created_at DESC').limit(50).where(user_id: @user.id).pluck(:post_item_id)
    @favorite_post_items = PostItem.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :user_name, :introduction, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
