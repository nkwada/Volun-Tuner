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
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  mount_uploader :image, ImageUploader

  # 追加したカラムの新規登録のバリデーション
  validates :username,
      presence: { message: "が入力されていません。" },
      length: { maximum: 15, minimum: 2, message: "は2文字以上15文字以内です。" }

  validates :lastname,
      presence: { message: "が入力されていません。" },
      length: { maximum: 10, message: "は10文字以内です。" }

  validates :firstname,
      presence: { message: "が入力されていません。" },
      length: { maximum: 10, message: "は10文字以内です。" }

  validates :kana_lastname,
      presence: { message: "が入力されていません。" },
      format: { with: /\A[\p{katakana}]+\z/, message: "はカタカナで入力してください。"},
      length: { maximum: 10, message: "は10文字以内です。" }

  validates :kana_firstname,
      presence: { message: "が入力されていません。" },
      format: { with: /\A[\p{katakana}]+\z/, message: "はカタカナで入力してください。"},
      length: { maximum: 10, message: "は10文字以内です。" }
  # バリデーションここまで


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

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end

