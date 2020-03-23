# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: 'test@admin', password: 'testadmin')

15.times do |n|
  User.create!(
    email: "test#{n + 1}@test",
    username: "テスト太郎#{n + 1}",
    lastname: 'テスト',
    firstname: '太郎',
    kana_lastname: 'テスト',
    kana_firstname: 'タロウ',
    password: 'aaaaaa'
  )
end

User.all.each do |user|
  user.events.create!(
    title: "テストイベント#{user.id}",
    content: 'テストイベントです',
    start_time: DateTime.strptime('03/30/2020 10:30', '%m/%d/%Y %H:%M'),
    prefecture: 13,
    address: '渋谷区道玄坂',
    user_id: user.id,
    latitude: 35.6581518,
    longitude: 139.6981574,
    tag_list: 'ゴミ拾い'
  )
end
