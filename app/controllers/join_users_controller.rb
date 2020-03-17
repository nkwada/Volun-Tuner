class JoinUsersController < ApplicationController
	before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    join_user = current_user.join_users.create(event_id: @event.id)
    # redirect_back(fallback_location: root_path) 非同期実装のためコメントアウト
  end

  def destroy
    @event = Event.find(params[:event_id])
    join_user = current_user.join_users.find_by(event_id: @event.id)
    join_user.destroy
    # redirect_back(fallback_location: root_path) 非同期実装のためコメントアウト
  end
end
