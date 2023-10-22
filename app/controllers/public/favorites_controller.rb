class Public::FavoritesController < ApplicationController

  def create
    post_item = PostItem.find(params[:post_item_id])
    favorite = current_user.favorites.new(post_item_id: post_item.id)
    favorite.save
    post_item.create_notification_favorite!(current_user)
    redirect_to post_item_path(post_item)
  end

  def destroy
    post_item = PostItem.find(params[:post_item_id])
    favorite = current_user.favorites.find_by(post_item_id: post_item.id)
    favorite.destroy
    redirect_to post_item_path(post_item)
  end

end
