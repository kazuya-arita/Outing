class Admin::SearchsController < ApplicationController
  
  def search
    @model = params[:model]
    
    if @model == "User"
      @users = User.search(params[:search])
    else  
      @post_items = PostItem.search(params[:search])
    end  
  end
  
end
