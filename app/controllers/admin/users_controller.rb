class Admin::UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
        user = User.find(params[:id])
        user.update(user_params)
        redirect_to admin_user_path(user.id), notice: 'ユーザー情報を更新しました'
    end

	private
    def user_params
        params.require(:user).permit(:username, :lastname, :firstname, :kana_lastname, :kana_firstname, :image, :image_cache, :remove_image )
    end
end
