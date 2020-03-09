class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	attachment :image
	has_many :events, dependent: :destroy
	has_many :join_users, dependent: :destroy
	has_many :joined_events, through: :join_users, source: :event
	has_many :likes, dependent: :destroy
	has_many :liked_events, through: :likes, source: :event
	has_many :comments

# ユーザーがイベントに対して、既に参加しているかどうかを判定
  def already_joined?(event)
    self.join_users.exists?(event_id: event.id)
  end

# ユーザーがイベントに対して、既にいいねしているかどうかを判定
  def already_liked?(event)
    self.likes.exists?(event_id: event.id)
  end
end

