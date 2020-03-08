class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @event = Event.find(params[:event_id])
    @comment.user_id = current_user.id
    @comment.event_id = @event.id
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
