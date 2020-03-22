FactoryBot.define do
  factory :event do
    title { Faker::Lorem.characters(number:5) }
    content { Faker::Lorem.characters(number:20) }
    address { Faker::Lorem.characters(number:20) }
    prefecture { '東京都' }
    tag_list { Faker::Lorem.characters(number:5) }
    user
  end
end