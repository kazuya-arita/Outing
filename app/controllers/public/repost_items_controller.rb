class Public::RepostItemsController < ApplicationController

  before_action :set_post_item

  def create
    @repost_item = RepostItem.create(user_id: current_user.id, post_item_id: @post_item.id)
    flash[:notice] = "リポストしました。"
    @post_item = PostItem.find(params[:post_item_id])
    if current_user.released?
      @post_item.create_notification_repost_item!(current_user)
    else
      if @post_item.user.following?(current_user)
        @post_item.create_notification_repost_item!(current_user)
      end
    end
    redirect_to post_item_path(@post_item.id)
  end

  def destroy
    @repost_item = current_user.repost_items.find_by(post_item: @post_item.id)
    @repost_item.destroy
    flash[:notice] = "リポストを取り消しました。"
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
