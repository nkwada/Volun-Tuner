class Event < ApplicationRecord
	belongs_to :user, optional: true
  	has_many :join_users, dependent: :destroy
  	has_many :joined_users, through: :join_users, source: :user, dependent: :destroy
    has_many :likes, dependent: :destroy
 	has_many :liked_users, through: :likes, source: :user, dependent: :destroy
 	has_many :comments, dependent: :destroy
 	mount_uploader :image, ImageUploader
 # 	geocoded_by :address
	# after_validation :geocode, if: :address_changed?
	acts_as_taggable
end
