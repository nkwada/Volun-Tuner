class Event < ApplicationRecord
	belongs_to :user, optional: true
  has_many :join_users, dependent: :destroy
  has_many :joined_users, through: :join_users, source: :user, dependent: :destroy
  has_many :likes, dependent: :destroy
 	has_many :liked_users, through: :likes, source: :user, dependent: :destroy
 	has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
 	mount_uploader :image, ImageUploader
	acts_as_taggable

	geocoded_by :address
  after_validation :geocode, if: lambda {|obj| obj.address_changed?}

  validates :title,
      presence: { message: "が入力されていません。" },
      length: { maximum: 30, message: "は30文字以内です。" }

  validates :content,
      presence: { message: "が入力されていません。" },
      length: { maximum: 200, message: "は200文字以内です。" }

  validates :address,
      presence: { message: "が入力されていません。" }

  validates :prefecture,
      presence: { message: "を選択してください。" }

  validates :tag_list,
      presence: { message: "を一つ以上入力してください。" }


    enum prefecture: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }


    def self.within_box(distance, latitude, longitude)
        distance = distance
        center_point = [latitude, longitude]
        box = Geocoder::Calculations.bounding_box(center_point, distance)
        self.within_bounding_box(box)
    end

    def create_notification_like!(current_user)
      # すでに「いいね」されているか検索
      temp = Notification.where(["visitor_id = ? and visited_id = ? and event_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
      # いいねされていない場合のみ、通知レコードを作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          event_id: id,
          visited_id: user_id,
          action: 'like'
        )
        # 自分の投稿に対するいいねの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

    def create_notification_join!(current_user)
      # すでに「いいね」されているか検索
      temp = Notification.where(["visitor_id = ? and visited_id = ? and event_id = ? and action = ? ", current_user.id, user_id, id, 'join'])
      # いいねされていない場合のみ、通知レコードを作成
      if temp.blank?
        notification = current_user.active_notifications.new(
          event_id: id,
          visited_id: user_id,
          action: 'join'
        )
        # 自分の投稿に対するいいねの場合は、通知済みとする
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

    def create_notification_comment!(current_user, comment_id)
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = Comment.select(:user_id).where(event_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
        save_notification_comment!(current_user, comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        event_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end

end
