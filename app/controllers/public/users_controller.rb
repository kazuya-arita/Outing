class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end 
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
  end
  
  def destroy
  end  
  
  private
  
  def user_params
    params.require(:user).permit(:nickname, :user_name, :introduction)
  end  
  
end
