class LikesController < ApplicationController
	before_action :authenticate_user!
  def create
    @event = Event.find(params[:event_id])
    like = current_user.likes.create(event_id: @event.id)
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @event = Event.find(params[:event_id])
    like = current_user.likes.find_by(event_id: @event.id)
    like.destroy
    # redirect_back(fallback_location: root_path)
  end
end
