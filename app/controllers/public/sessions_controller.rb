# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    post_items_path
  end

  def after_sign_out_path_for(resource)
    post_items_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :user_name, :email])
  end

  def user_state
    @user = User.find_by(user_name: params[:user][:user_name])
    return if !@user
    if @user.valid_password?(params[:user][:password])
      if @user.is_active == true
      else
        render :new
      end
    end
  end

end
