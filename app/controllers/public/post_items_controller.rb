class Public::PostItemsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @user = User.find(current_user.id)
      @post_items = @user.followings_post_items_with_repost_items.limit(50)
    else
      @post_items = PostItem.hide_nonreleased_post_items.limit(50)
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
      flash[:alert] = "投稿できませんでした。写真と場所が入力されているか確認してください。"
      redirect_to new_post_item_path
    end
  end

  def show
    @post_item = PostItem.find(params[:id])
    @user = User.find(@post_item.user_id)
    @post_comment = PostComment.new
    if @user.nonreleased?
      redirect_to post_items_path
    end
  end

  def destroy
    post_item = PostItem.find(params[:id])
    if current_user.id = post_item.user_id
      if post_item.destroy
        flash[:notice] = "投稿を削除しました。"
        redirect_to post_items_path
      else
        flash.now[:alert] = "投稿を削除できませんでした。"
        render :show
      end
    else
      redirect_to post_items_path
    end
  end

  def location
    @post_item = PostItem.find(params[:id])
  end

  private

  def post_item_params
    params.require(:post_item).permit(:image, :post_item, :address, :user_id, :lat, :lng)
  end

end
