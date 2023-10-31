class Public::NotificationsController < ApplicationController
  
  def index
    @user = User.find(params[:id])
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end  
  end  
  
end
