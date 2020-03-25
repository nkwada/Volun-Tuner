# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "ボランティア #{n}" }
    content { Faker::Lorem.characters(number: 20) }
    address { Faker::Lorem.characters(number: 20) }
    prefecture { '東京都' }
    start_time { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    tag_list { Faker::Lorem.characters(number: 5) }
    user
  end
end
