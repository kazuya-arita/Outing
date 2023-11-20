class Public::PostCommentsController < ApplicationController

  def create
    post_item = PostItem.find(params[:post_item_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_item_id = post_item.id
    if comment.save
      if current_user.released?
        post_item.create_notification_comment!(current_user, comment.id)
      end
      flash[:notice] = "コメントを投稿しました。"
      redirect_to post_item_path(post_item)
    else
      flash[:alert] = "コメントを投稿できませんでした。"
      redirect_to post_item_path(post_item)
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    if post_comment.destroy
      flash[:alert] = "コメントを削除しました。"
      redirect_to post_item_path(params[:post_item_id])
    else
      flash[:alert] = "コメントを削除できませんでした。"
      redirect_to post_item_path(params[:post_item_id])
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
