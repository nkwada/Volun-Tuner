class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	attachment :image
	has_many :events, dependent: :destroy
	has_many :join_users, dependent: :destroy
	has_many :joined_events, through: :join_users, source: :event

# ユーザーがイベントに対して、既に参加しているかどうかを判定
  def already_joined?(event)
    self.join_users.exists?(event_id: event.id)
  end
end

