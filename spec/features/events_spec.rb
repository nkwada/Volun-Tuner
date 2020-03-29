require 'rails_helper'

RSpec.feature "Events", type: :feature do
  scenario "ユーザーが新しいボランティアを主催する" do
  	user = FactoryBot.create(:user)

  	visit root_path
  	click_link "ログイン"
  	fill_in "メールアドレス", with: user.email
  	fill_in "パスワード", with: user.password
  	click_button "ログイン"

  	expect {
  		click_link "ボランティアを主催する"
  		fill_in "title", with: "Test Volunteer"
  		fill_in "content", with: "ボランティアをします"
  		select "東京都", from: "prefecture"
  		fill_in "address", with: "渋谷区道玄坂"
  		fill_in "tag_list", with: "テストカテゴリー"
  		within "#host-button" do
        click_button "主催する"
      end
      within ".modal-footer" do
        click_button "主催する"
      end

  	expect(page).to have_content "新しいボランティアを主催しました"
  	expect(page).to have_content "Test Volunteer"
  	expect(page).to have_content "#{user.username}"

  	}.to change(user.events, :count).by(1)
  end
end
