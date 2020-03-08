class Like < ApplicationRecord
  belongs_to :event
  belongs_to :user
  # 一人が一つのイベントに対して、一つしかいいねをつけられないように
  validates_uniqueness_of :event_id, scope: :user_id
end
