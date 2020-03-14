class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	has_many :events, dependent: :destroy
	has_many :join_users, dependent: :destroy
	has_many :joined_events, through: :join_users, source: :event, dependent: :destroy
	has_many :likes, dependent: :destroy
	has_many :liked_events, through: :likes, source: :event, dependent: :destroy
	has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower, dependent: :destroy
  mount_uploader :image, ImageUploader


# ユーザーがイベントに対して、既に参加しているかどうかを判定
  def already_joined?(event)
    self.join_users.exists?(event_id: event.id)
  end

# ユーザーがイベントに対して、既にいいねしているかどうかを判定
  def already_liked?(event)
    self.likes.exists?(event_id: event.id)
  end

# ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

# ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

# 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end

