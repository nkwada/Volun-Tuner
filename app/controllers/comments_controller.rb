# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find(params[:event_id])
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.event_id = @event.id
    @comment.save
    @event = @comment.event
    @event.create_notification_comment!(current_user, @comment.id)
    # if @comment.save 非同期実装のためコメントアウト
    #   redirect_back(fallback_location: root_path)
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end

  def destroy
    @comment = Comment.find(params[:event_id])
    @event = @comment.event
    @comments = @event.comments
    @comment.destroy
    # redirect_back(fallback_location: root_path) 非同期実装のためコメントアウト
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
