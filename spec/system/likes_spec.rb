require 'rails_helper'

describe 'ajaxでのいいねテスト' do
    let(:user) { create(:user) }
    let!(:test_user) { create(:user) }
    let!(:event) { create(:event, user: test_user) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  describe 'ボランティア詳細画面' do
    before do
      visit event_path(event)
    end
    context 'いいねをクリックした場合', js: true do
      it 'いいねできる' do
        find('.btn-outline-danger').click
        expect(page).to have_css '.btn-secondary'
        expect(page).to have_css "div#like-#{event.id}", text: '1'
      end
    end
    context 'いいねを削除した場合', js: true do
      it 'いいねを取り消せる' do
        find('.btn-outline-danger').click
        find('.btn-secondary').click
        expect(page).to have_css '.btn-outline-danger'
        expect(page).to have_css "div#like-#{event.id}", text: '0'
      end
    end
  end
end