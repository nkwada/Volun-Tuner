# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  # 名前が空欄で登録できない→名前を空欄で登録したらfalse
  # バリデーションしていない状態で失敗→設定したら成功
  # 登録できるかできないか 登録できたら失敗
  # エラーメッセージがなければ失敗
  describe User do
    it '有効なファクトリを持つこと' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  before do
    @user = build(:user)
  end
  it '値が全て適切' do
    expect(@user.valid?).to eq(true)
  end

  # it "名前がなければ無効な状態であること" do
  #   user = FactoryBot.build(:user, firstname: nil)
  #   user.valid?
  #   expect(user.errors[:firstname]).to include("が入力されていません。")
  # end

  describe 'バリデーションのテスト' do
    let(:user) { build(:user) }
    subject { test_user.valid? }
    context 'usernameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.username = nil
        is_expected.to eq false
      end
      it '2文字以上であること' do
        test_user.username = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '15文字以下であること' do
        test_user.username = Faker::Lorem.characters(number: 16)
        is_expected.to eq false
      end
    end
    context 'lastnameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.lastname = nil
        is_expected.to eq false
      end
      it '10文字以下であること' do
        test_user.lastname = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
    end
    context 'firstnameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.firstname = nil
        is_expected.to eq false
      end
      it '10文字以下であること' do
        test_user.firstname = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
    end
    context 'kana_lastnameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.kana_lastname = nil
        is_expected.to eq false
      end
      it '10文字以下であること' do
        test_user.kana_lastname = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
    end
    context 'kana_lastnameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.kana_firstname = nil
        is_expected.to eq false
      end
      it '10文字以下であること' do
        test_user.kana_firstname = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
    end
    context 'emailカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.email = nil
        is_expected.to eq false
      end
      it '重複したメールアドレスなら無効であること' do
        FactoryBot.create(:user, email: "test@example.com")
        user = FactoryBot.build(:user, email: "test@example.com")
        user.valid?
        expect(user.errors[:email]).to include("はすでに存在します")
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Eventモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:events).macro).to eq :has_many
      end
      it 'joined_eventカラムと1:Nとなっている' do
        expect(User.reflect_on_association(:joined_events).macro).to eq :has_many
      end
    end

    context 'JoinUserモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:join_users).macro).to eq :has_many
      end
    end

    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end
      it 'liked_eventカラムと1:Nとなっている' do
        expect(User.reflect_on_association(:liked_events).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Relationshipモデルとの関係' do
      it 'followingカラムと1:Nとなっている' do
        expect(User.reflect_on_association(:following).macro).to eq :has_many
      end
      it 'followerカラムと1:Nとなっている' do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
      it 'active_relationshipカラムと1:Nとなっている' do
        expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
      end
      it 'passive_relationshipカラムと1:Nとなっている' do
        expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it 'active_notificationカラムと1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it 'passive_notificationカラムと1:Nとなっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
end
# アソシエーションのテスト
