class Public::RepostItemsController < ApplicationController

  before_action :set_post_item

  def create
    @repost_item = RepostItem.create(user_id: current_user.id, post_item_id: @post_item.id)
    redirect_to post_item_path(@post_item.id)
  end

  def destroy
    @repost_item = current_user.repost_items.find_by(post_item: @post_item.id)
    @repost_item.destroy
    redirect_to post_item_path(@post_item.id)
  end

  private

  def set_post_item
    @post_item = PostItem.find(params[:post_item_id])
    if @post_item.nil?
      redirect_to post_items_path, alert: "投稿は削除されました。"
    end
  end

end
