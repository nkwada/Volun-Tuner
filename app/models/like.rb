# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :event
  belongs_to :user
  # 一人が一つのイベントに対して、一つしかいいねをつけられないように
  validates :event_id, uniqueness: { scope: :user_id }
end
