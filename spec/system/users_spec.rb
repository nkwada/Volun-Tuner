require 'rails_helper'


describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[username]', with: Faker::Internet.username(specifier: 3..14)
        fill_in 'user[lastname]', with: Faker::Internet.username(specifier: 1..9)
        fill_in 'user[firstname]', with: Faker::Internet.username(specifier: 1..9)
        fill_in 'user[kana_lastname]', with: 'カタカナ'
        fill_in 'user[kana_firstname]', with: 'カタカナ'
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '登録'

        expect(page).to have_content 'アカウント登録が完了'
      end
      it '新規登録に失敗する' do
        fill_in 'user[username]', with: nil
        fill_in 'user[lastname]', with: nil
        fill_in 'user[firstname]', with: nil
        fill_in 'user[kana_lastname]', with: nil
        fill_in 'user[kana_firstname]', with: nil
        fill_in 'user[email]', with: nil
        fill_in 'user[password]', with: nil
        fill_in 'user[password_confirmation]', with: nil
        click_button '登録'

        expect(page).to have_content 'エラー'
      end
    end
  end
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
