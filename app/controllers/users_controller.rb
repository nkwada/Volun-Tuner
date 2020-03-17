class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:top]

	def top
	end

	def show
		@user = User.find(params[:id])

		#フォローしているユーザーを取得
	    follow_users = @user.following
	   #フォローユーザーのツイートを表示
	    @events = Event.where(user_id: follow_users)
	end

	def edit
		@user = current_user
	end

	def update
		user = current_user
		user.update(user_params)
		redirect_to user_path(user.id)
	end

	def following
		@title = "フォロー"
		@user  = User.find(params[:id])
		@users = @user.following.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "フォロワー"
		@user  = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

	private

	def user_params
		params.require(:user).permit(:username, :lastname, :firstname, :kana_lastname, :kana_firstname, :image, :image_cache, :remove_image )
	end
end
