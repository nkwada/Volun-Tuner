# frozen_string_literal: true

class NotificationsController < ApplicationController
  def read
    current_user.passive_notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
