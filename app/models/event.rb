class Event < ApplicationRecord
	belongs_to :user
  	has_many :join_users
  	has_many :joined_users, through: :join_users, source: :user
    has_many :likes
 	has_many :liked_users, through: :likes, source: :user
 	has_many :comments
end
