class Admin::HomesController < ApplicationController

  def top
    @post_items = PostItem.all.order('created_at DESC').limit(50)
  end

  def show
    @post_item = PostItem.find(params[:id])
  end
  
  def destroy
    post_item = PostItem.find(params[:id])
    if post_item.destroy
      flash[:notice] = "不適切な投稿を削除しました。"
      #post_item.create_notification_warning!(current_admin)
      redirect_to admin_path
    else
      flash.now[:alert] = "投稿を削除できませんでした。"
      render :show
    end
  end

end
