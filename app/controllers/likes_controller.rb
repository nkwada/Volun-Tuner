# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @event = Event.find(params[:event_id])
    like = current_user.likes.create(event_id: @event.id)
    # redirect_back(fallback_location: root_path) 非同期実装のためコメントアウト
    @event.create_notification_like!(current_user)
  end

  def destroy
    @event = Event.find(params[:event_id])
    like = current_user.likes.find_by(event_id: @event.id)
    like.destroy
    # redirect_back(fallback_location: root_path) 非同期実装のためコメントアウト
  end
end
