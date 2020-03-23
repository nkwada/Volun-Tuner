# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :notifications, dependent: :destroy
  validates :content, presence: true
end
