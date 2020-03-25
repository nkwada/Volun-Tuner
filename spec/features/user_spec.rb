require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe 'ユーザーログイン' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      let(:test_user) { user }
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'ログイン'

        expect(page).to have_content 'ログインしました'
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: nil
        fill_in 'user[password]', with: nil
        click_button 'ログイン'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end
