class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

# 新規登録後とログイン後のパスを指定
  # 新規登録時はユーザーとアドミンで別に指定
	def after_sign_in_path_for(resource)
	  case resource
    when User
      user_path(current_user)
    when Admin
      admin_users_path
    end
	end

	def after_sign_up_path_for(resource)
  	user_path(current_user)
	end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :lastname, :firstname, :kana_lastname, :kana_firstname])
  end
end
