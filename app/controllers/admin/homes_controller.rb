class Admin::HomesController < ApplicationController
  
  def top
    @post_items = PostItem.all.order('created_at DESC').limit(50)
  end 
  
  def search 
    @post_items = PostItem.search(params[:search])
  end  
  
end
