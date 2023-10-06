# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    posts_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :user_name, :email])
  end

   def user_state
      @user = User.find_by(email: params[:user][:user_name])
      return if !@user
      if @user.valid_password?(params[:user][:password])
       if @user.is_deleted
        render :new
       else
       end
      end
   end

end
