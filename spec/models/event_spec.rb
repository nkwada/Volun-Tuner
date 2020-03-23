# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Eventモデルのテスト', type: :model do
  before do
    @event = build(:event)
  end
  it '値が全て適切' do
    expect(@event.valid?).to eq(true)
  end

  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:event) { build(:event, user_id: user.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        event.title = nil
        expect(event.valid?).to eq false
      end
    end
    context 'contentカラム' do
      it '空欄でないこと' do
        event.content = nil
        expect(event.valid?).to eq false
      end
      it '200文字以下であること' do
        event.content = Faker::Lorem.characters(number: 201)
        expect(event.valid?).to eq false
      end
    end
    context 'addressカラム' do
      it '空欄でないこと' do
        event.address = nil
        expect(event.valid?).to eq false
      end
    end
    context 'prefectureカラム' do
      it '空欄でないこと' do
        event.prefecture = nil
        expect(event.valid?).to eq false
      end
    end
    context 'tag_listカラム' do
      it '空欄でないこと' do
        event.tag_list = nil
        expect(event.valid?).to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Event.reflect_on_association(:user).macro).to eq :belongs_to
      end
      it 'joined_userカラムと1:Nとなっている' do
        expect(Event.reflect_on_association(:joined_users).macro).to eq :has_many
      end
      it 'liked_userカラムと1:Nとなっている' do
        expect(Event.reflect_on_association(:liked_users).macro).to eq :has_many
      end
    end
    context 'JoinUserモデルとの関係' do
      it '1:Nとなっている' do
        expect(Event.reflect_on_association(:join_users).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(Event.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Event.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Event.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end

  describe '外部キーのテスト' do
    context '保存できない場合' do
      it 'user_idが無ければ無効' do
        @event = Event.new(user_id: nil)
        @event.valid?
        expect(@event.valid?).to eq(false)
      end
    end
    context '保存できる場合' do
      it 'user_idがあれば有効' do
        @user = build(:user)
        expect(FactoryBot.create(:event, user_id: @user.id)).to be_valid
      end
    end
  end
end
