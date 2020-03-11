class Event < ApplicationRecord
	belongs_to :user
  	has_many :join_users
  	has_many :joined_users, through: :join_users, source: :user
    has_many :likes
 	has_many :liked_users, through: :likes, source: :user
 	has_many :comments
 	mount_uploader :image, ImageUploader
 	geocoded_by :address
	after_validation :geocode, if: :address_changed?
	acts_as_taggable
end
