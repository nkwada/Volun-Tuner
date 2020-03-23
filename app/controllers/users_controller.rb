# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[top about]

  def top; end

  def about; end

  def show
    @user = User.find(params[:id])

    @notifications = current_user.passive_notifications.page(params[:page]).per(4)

    @user_joins = @user.joined_events.page(params[:page]).per(3)
    @user_hosts = @user.events.page(params[:page]).per(3)
    @user_likes = @user.liked_events.page(params[:page]).per(3)

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
    @title = 'フォロー'
    @user  = User.find(params[:id])
    # @users = @user.following.page(params[:page]).per(5)
    # 上記ではエラーが出るので下記に変更
    @users = @user.following
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(5)
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user  = User.find(params[:id])
    @users = @user.followers
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(5)
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:username, :lastname, :firstname, :kana_lastname, :kana_firstname, :image, :image_cache, :remove_image)
  end
end
