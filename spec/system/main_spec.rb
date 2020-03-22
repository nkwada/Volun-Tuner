require 'rails_helper'

describe 'ユーザー権限のテスト'  do
  let!(:user) { create(:user) }
  let!(:book) { create(:book, user: user) }
  describe 'ログインしていない場合' do
    context '投稿関連のURLにアクセス' do
      it '一覧画面に遷移できない' do
        visit books_path
        expect(current_path).to eq('/users/sign_in')
      end
      it '編集画面に遷移できない' do
        visit edit_book_path(book.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it '詳細画面に遷移できない' do
        visit book_path(book.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
  describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
    context 'ユーザー関連のURLにアクセス' do
      it '一覧画面に遷移できない' do
        visit users_path
        expect(current_path).to eq('/users/sign_in')
      end
      it '編集画面に遷移できない' do
        visit edit_user_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it '詳細画面に遷移でない' do
        visit user_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
end