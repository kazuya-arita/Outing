class Admin::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @post_items = @user.post_items_with_repost_items.limit(50)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_path
  end

  private

  def user_params
    params.require(:user).permit(:is_active)
  end

end
