class Public::UsersController < ApplicationController
  before_action :set_user

  def show
    @post_items = @user.post_items_with_repost_items.limit(50)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "更新しました。"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "更新できませんでした。"
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to post_items_path
  end

  def confirm
  end

  def favorites
    favorites = Favorite.order('created_at DESC').limit(50).where(user_id: @user.id).pluck(:post_item_id)
    @favorite_post_items = PostItem.find(favorites)
  end

  def release
    @user.released! unless @user.released?
    flash[:notice] = "アカウントを公開しました。"
    redirect_to user_path(@user.id)
  end

  def nonrelease
    @user.nonreleased! unless @user.nonreleased?
    flash[:notice] = "アカウントを非公開にしました。"
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :user_name, :introduction, :profile_image)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
