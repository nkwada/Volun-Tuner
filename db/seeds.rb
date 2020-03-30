# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: 'test@admin', password: 'testadmin')

50.times do |n|
  gimei = Gimei.name
  User.create!(
    email: "test#{n + 1}@test",
    username: gimei.first.hiragana + "#{n + 1}",
    lastname: gimei.last.kanji,
    firstname: gimei.first.kanji,
    kana_lastname: gimei.last.katakana,
    kana_firstname: gimei.first.katakana,
    password: 'aaaaaa'
  )
end

200.times do |event|
  address = Gimei.address
  Event.create!(
    title: "#{address.prefecture.to_s}でボランティアをしましょう",
    content: 'seedファイルで作られた、ボランティアです。みんなでボランティアをして社会貢献しよう。',
    start_time: DateTime.strptime("04/#{rand(01..30)}/2020 #{rand(00..23)}:30", '%m/%d/%Y %H:%M'),
    prefecture: address.prefecture.to_s,
    address: address.city.to_s + address.town.to_s,
    user_id: rand(1..50),
    tag_list: 'ゴミ拾い'
  )
end

400.times do |join|
  JoinUser.create(
    event_id: rand(1..100),
    user_id: rand(1..50)
  )
end

400.times do |like|
  Like.create(
    event_id: rand(1..100),
    user_id: rand(1..50)
  )
end

