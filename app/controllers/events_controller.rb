class EventsController < ApplicationController
  def index
  	@events = Event.all
  end

  def show
  	@event = Event.find(params[:id])
  	@join_user = JoinUser.new
  	@like = Like.new
 	  @comments = @event.comments
    @comment = Comment.new
  end

  def new
    @event = Event.new
  	# confirmにパラメータで渡す
  end

  def create
  	event = current_user.events.build(event_params)
  	event.save
  	redirect_to event_path(event.id)
  end

  def edit
  	@event = Event.find(params[:id])
  end

  def update
	event = Event.find(params[:id])
	event.update(event_params)
	redirect_to event_path(event.id)
  end

# イベント確認画面
  def confirm
  	# パラメータで確認画面へ
  	@event = Event.new(event_params)
  	# @event.title = params[:event][:title]
  	# @event.content = params[:content]
  	# @event.date = params[:date]
  	# @event.time = params[:time]
  	# @event.postal_code = params[:postal_code]
  	# @event.address = params[:address]
  end

  private

  def event_params
  	params.require(:event).permit(:title, :content, :start_time, :postal_code, :address, :image, :image_cache, :remove_image)
  end

end
