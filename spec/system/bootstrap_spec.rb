require 'rails_helper'

describe 'boostrapのテスト' do
	let(:user) { create(:user) }
	let!(:book) { create(:book, user: user) }
	describe 'グリッドシステムのテスト' do
		before do
			visit new_user_session_path
			fill_in 'user[name]', with: user.name
			fill_in 'user[password]', with: user.password
			click_button 'Log in'
		end
		context 'ユーザー関連画面' do
			it '一覧画面' do
				visit users_path
				expect(page).to have_selector('.container .row .col-xs-3')
				expect(page).to have_selector('.container .row .col-xs-9')
			end
			it '詳細画面' do
				visit user_path(user)
				expect(page).to have_selector('.container .row .col-xs-3')
				expect(page).to have_selector('.container .row .col-xs-9')
			end
		end
		context '投稿関連画面' do
			it '一覧画面' do
				visit books_path
				expect(page).to have_selector('.container .row .col-xs-3')
				expect(page).to have_selector('.container .row .col-xs-9')
			end
			it '詳細画面' do
				visit book_path(book)
				expect(page).to have_selector('.container .row .col-xs-3')
				expect(page).to have_selector('.container .row .col-xs-9')
			end
		end
	end
end