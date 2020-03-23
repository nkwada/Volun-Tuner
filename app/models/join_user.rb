# frozen_string_literal: true

class JoinUser < ApplicationRecord
  belongs_to :event
  belongs_to :user
  # 一人が一つのイベントに対して一回だけ参加出来るように
  validates :event_id, uniqueness: { scope: :user_id }
end
