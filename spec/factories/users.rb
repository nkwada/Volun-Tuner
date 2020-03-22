FactoryBot.define do
  factory :user do
    username { Faker::Lorem.characters(number:10) }
    lastname { Faker::Lorem.characters(number:10) }
    firstname { Faker::Lorem.characters(number:10) }
    kana_lastname { 'テスト' }
    kana_firstname { 'テスト' }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end