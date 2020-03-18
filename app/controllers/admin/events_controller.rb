class Admin::EventsController < ApplicationController
	def index
		@events = Event.all
	end

	def destroy
        event = Event.find(params[:id])
        event.destroy
        redirect_to admin_events_path, alert: 'ボランティアを削除しました'
	end
end
