require 'rails_helper'

RSpec.feature "Events", type: :feature do
  scenario "ユーザーが新しいボランティアを主催する" do
  	user = FactoryBot.create(:user)

  	visit root_path
  	click_link "ログイン"
  	fill_in "メールアドレス", with: user.email
  	fill_in "パスワード", with: user.password
  	click_button "ログイン"
save_and_open_page
  	expect {
  		click_link "ボランティアを主催する"
  		fill_in "タイトル", with: "Test Volunteer"
  		fill_in "内容", with: "Trying out Capybara"
  		select "東京都", from: "都道府県"
  		fill_in "住所", with: "渋谷区道玄坂"
  		fill_in "カテゴリータグ", with: "テストカテゴリー"
  		click_button "投稿"

  	expect(page).to have_content "新しいボランティアを主催しました"
  	expect(page).to have_content "Test Volunteer"
  	expect(page).to have_content "#{user.username}"

  	}.to change(user.events, :count).by(1)
  end
end
