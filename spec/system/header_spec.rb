require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit root_path
    end
    context 'ヘッダーの表示を確認' do
      subject { page }
      it 'タイトルが表示される' do
        is_expected.to have_content 'Bookers'
      end
      it 'Homeリンクが表示される' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match(/home/i)
        #is_expected.to have_content 'Home'
      end
      it 'Aboutリンクが表示される' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match(/about/i)
        #is_expected.to have_content 'About'
      end
      it 'Sign upリンクが表示される' do
        signup_link = find_all('a')[2].native.inner_text
        expect(signup_link).to match(/sign up/i)
        #is_expected.to have_content 'Sign up'
      end
      it 'loginリンクが表示される' do
        login_link = find_all('a')[3].native.inner_text
        expect(login_link).to match(/login/i)
        #is_expected.to have_content 'login'
      end
    end
    context 'ヘッダーのリンクを確認' do
      subject { current_path }
      it 'Home画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq(root_path)
      end
      it 'About画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq('/home/about')
      end
      it '新規登録画面に遷移する' do
        signup_link = find_all('a')[2].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq(new_user_registration_path)
      end
      it 'ログイン画面に遷移する' do
        login_link = find_all('a')[3].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq(new_user_session_path)
      end
    end
  end

  describe 'ログインしている場合' do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'user[name]', with: user.name
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end
    context 'ヘッダーの表示を確認' do
      subject { page }
      it 'タイトルが表示される' do
        is_expected.to have_content 'Bookers'
      end
      it 'Homeリンクが表示される' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match(/home/i)
      end
      it 'Usersリンクが表示される' do
        users_link = find_all('a')[1].native.inner_text
        expect(users_link).to match(/users/i)
      end
      it 'Booksリンクが表示される' do
        books_link = find_all('a')[2].native.inner_text
        expect(books_link).to match(/books/i)
      end
      it 'logoutリンクが表示される' do
        logout_link = find_all('a')[3].native.inner_text
        expect(logout_link).to match(/logout/i)
      end
    end

    context 'ヘッダーのリンクを確認' do
      subject { current_path }
      it 'Home画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq('/users/'+user.id.to_s)
      end
      it 'Users画面に遷移する' do
        users_link = find_all('a')[1].native.inner_text
        users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq('/users')
      end
      it 'Books画面に遷移する' do
        books_link = find_all('a')[2].native.inner_text
        books_link = books_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link books_link
        is_expected.to eq('/books')
      end
      it 'logoutする' do
        logout_link = find_all('a')[3].native.inner_text
        logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link logout_link
        expect(page).to have_content 'Signed out successfully.'
      end
    end
  end
end
