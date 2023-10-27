class Public::PostItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @post_items = @user.followings_post_items_with_repost_items.limit(50)
    else
      @post_items = PostItem.all.order('created_at DESC').limit(50)
    end
  end

  def new
    @post_item = PostItem.new
  end

  def create
    @post_item = PostItem.new(post_item_params)
    @post_item.user_id = current_user.id
    if @post_item.save
      flash[:notice] = "投稿しました。"
      redirect_to post_items_path
    else
      flash.now[:alert] = "投稿できませんでした。"
      render :new
    end
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
