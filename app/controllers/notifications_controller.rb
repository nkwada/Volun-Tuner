class NotificationsController < ApplicationController

	def read
    	current_user.passive_notifications.where(checked: false).each do |notification|
			notification.update_attributes(checked: true)
    	end
	end
end
