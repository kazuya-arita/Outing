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
    if @user.update(user_params)
      if @user.is_active == true
        flash[:notice] = "ユーザーのステータスを有効にしました。"
      else
        flash[:alert] = "ユーザーのステータスを無効にしました。"
      end
      redirect_to admin_path
    else
      flash[:alert] = "ユーザーのステータスを更新できませんでした。"
      redirect_to :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_active)
  end

end
