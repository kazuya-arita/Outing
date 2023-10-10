class Public::PostCommentsController < ApplicationController

  def create
    post_item = PostItem.find(params[:post_item_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_item_id = post_item.id
    comment.save
    redirect_to post_item_path(post_item)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
