class Public::RepostItemsController < ApplicationController
  
  before_action :set_post_item
  
  def create
    if RepostItem.find_by(user_id: current_user.id, post_item_id: @post_item.id)
      redirect_to post_item_path, alert: "既にリポスト済みです。"
    else
      @repost_item = RepostItem.create(user_id: current_user.id, post_item_id: @post_item.id)
    end  
  end
  
  def destroy
    @repost_item = current_user.repost_items.find_by(post_item: @post_item.id)
    if @repost_item.present?
      @repost_item.destroy
    else
      redirect_to post_item_path, alert: "既にリポストを取り消し済みです。"
    end  
  end  
  
  private
  
  def set_post_item
    @post_item = PostItem.find(params[:post_id])
    if @post_item.nil?
      redirect_to post_item_path, alert: "投稿は削除されました。"
    end  
  end  
  
end
