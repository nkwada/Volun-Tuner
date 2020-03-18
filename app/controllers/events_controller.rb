class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search_index]

  def index
  	@events = Event.all
    # ランダムに取得
    @event_randoms = Event.order("RANDOM()").limit(6)

    if user_signed_in?
      #フォローしているユーザーを取得
      follow_users = current_user.following
      #フォローユーザーのツイートを表示
      @follow_events = Event.where(user_id: follow_users).limit(6)
    end
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
  end


  def create
  	event = current_user.events.build(event_params)
  	if event.save
  	 redirect_to event_path(event.id)
    else
      @event = event
      render 'new'
    end
  end


  def edit
  	@event = Event.find(params[:id])
  end


  def update
  	event = Event.find(params[:id])
  	if event.update(event_params)
  	redirect_to event_path(event.id)
    else
      @event = event
      render 'edit'
    end
  end


  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to user_path(current_user)
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
      # セレクトボックスがタイトルの時
      search = params[:search]
      @events = Event.where(['title LIKE ?', "%#{search}%"])
    elsif params[:selected] == 'Content'
      # セレクトボックスが内容の時
      search = params[:search]
      @events = Event.where(['content LIKE ?', "%#{search}%"])
    elsif params[:tag_name]
      # タグをクリックした時に同じタグ名のイベントを表示
      @events = Event.tagged_with("#{params[:tag_name]}")
    elsif params[:latitude]
      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      # 10kmは約6.21371マイル　半径10km以内のイベントを表示
      @events = Event.within_box(6.21371, latitude, longitude)
    elsif params[:prefecture]
      @events = Event.where(prefecture: params[:prefecture])
    else
      @events = Event.all.reverse_order
    end
  end



  private

  def event_params
  	params.require(:event).permit(:title, :content, :start_time, :prefecture, :address, :image, :image_cache, :remove_image, :tag_list, :latitude, :longitude)
  end

end
