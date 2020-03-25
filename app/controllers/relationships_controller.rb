# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    flash.now[:follow] = 'フォローしました!'
    @user.create_notification_follow!(current_user)
    # 非同期のためコメントアウト
    # redirect_to user, notice: "#{user.username}さんをフォローしました！"
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    flash.now[:follow] = 'フォローを解除しました...'
    current_user.unfollow(@user)
    # 非同期のためコメントアウト
    # redirect_to user, alert: "#{user.username}さんのフォローを解除しました..."
  end
end
