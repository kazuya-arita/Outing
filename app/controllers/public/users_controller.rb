class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @posts = @user.post_items
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

  private

  def user_params
    params.require(:user).permit(:nickname, :user_name, :introduction, :profile_image)
  end

end
