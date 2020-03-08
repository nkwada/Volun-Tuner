class UsersController < ApplicationController
	def top
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = current_user
	end

	def update
		user = current_user
		user.update(user_params)
		redirect_to user_path(user.id)
	end

	private

	def user_params
		params.require(:user).permit(:username, :lastname, :firstname, :kana_lastname, :kana_firstname, :image )
	end
end
