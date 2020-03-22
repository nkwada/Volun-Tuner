class Admin::EventsController < ApplicationController
	def index
		@events = Event.page(params[:page]).reverse_order.per(5)
	end

	def destroy
        event = Event.find(params[:id])
        event.destroy
        redirect_to admin_events_path, alert: 'ボランティアを削除しました'
	end
end
