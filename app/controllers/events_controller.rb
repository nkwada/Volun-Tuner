class EventsController < ApplicationController
  def index
  	@events = Event.all.reverse_order
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
    # event_paramsを書けば下記を省略できる
  	# @event.title = params[:event][:title]
  	# @event.content = params[:content]
  	# @event.date = params[:date]
  	# @event.time = params[:time]
  	# @event.postal_code = params[:postal_code]
  	# @event.address = params[:address]
  end

  def search_index
    # @events = Event.search(params[:search])
    if params[:selected] == 'Title'
      search = params[:search]
      @events = Event.where(['title LIKE ?', "%#{search}%"])
    elsif params[:selected] == 'Content'
      search = params[:search]
      @events = Event.where(['content LIKE ?', "%#{search}%"])
    end
  end

  def search
    latitude = params[:latitude]
    longitude = params[:longitude]
    @places = Event.all.within(1000, origin: [latitude, longitude])
  end

  private

  def event_params
  	params.require(:event).permit(:title, :content, :start_time, :postal_code, :address, :image, :image_cache, :remove_image, :tag_list)
  end

end
