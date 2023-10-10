class Public::PostItemsController < ApplicationController
  
  def index
    @post_items = PostItem.all.order('id DESC').limit(50)
  end 
  
  def new
    @post_item = PostItem.new
  end
  
  def create
    @post_item = PostItem.new(post_item_params)
    @post_item.user_id = current_user.id
    @post_item.save
    redirect_to post_items_path
  end  
  
  def show
    @post_item = PostItem.find(params[:id])
    @post_comment = PostComment.new
    @user = User.find(params[:id])
  end
  
  def destroy
    post_item = PostItem.find(params[:id])
    post_item.destroy
    redirect_to post_items_path
  end  
  
  private
  
  def post_item_params
    params.require(:post_item).permit(:image, :post_item, :address, :user_id)
  end
  
end
