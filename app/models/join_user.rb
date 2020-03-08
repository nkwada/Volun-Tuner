class JoinUser < ApplicationRecord
  belongs_to :event
  belongs_to :user
  # 一人が一つのイベントに対して一回だけ参加出来るように
  validates_uniqueness_of :event_id, scope: :user_id
end
