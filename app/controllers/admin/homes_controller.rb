class Admin::HomesController < ApplicationController

  def top
    @post_items = PostItem.all.order('created_at DESC').limit(50)
  end

  def show
    @post_item = PostItem.find(params[:id])
  end

end
