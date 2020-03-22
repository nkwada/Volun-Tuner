FactoryBot.define do
  factory :user do
    username { Faker::Lorem.characters(number:10) }
    lastname { Faker::Lorem.characters(number:10) }
    firstname { Faker::Lorem.characters(number:10) }
    kana_lastname { Faker::Lorem.characters(number:10) }
    kana_firstname { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number:20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end