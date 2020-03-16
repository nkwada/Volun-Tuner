class Event < ApplicationRecord
	belongs_to :user, optional: true
  has_many :join_users, dependent: :destroy
  has_many :joined_users, through: :join_users, source: :user, dependent: :destroy
  has_many :likes, dependent: :destroy
 	has_many :liked_users, through: :likes, source: :user, dependent: :destroy
 	has_many :comments, dependent: :destroy
 	mount_uploader :image, ImageUploader
	acts_as_taggable

	geocoded_by :address
	after_validation :geocode, if: :address_changed?

  validates :title, presence: true, length: { maximum: 10 }
  validates :content, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true

    def self.within_box(distance, latitude, longitude)
        distance = distance
        center_point = [latitude, longitude]
        box = Geocoder::Calculations.bounding_box(center_point, distance)
        self.within_bounding_box(box)
    end

end
