require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "#top" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :top
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :top
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do

			it "302レスポンスを返すこと" do
				get :top
				expect(response).to be_success
			end

			it "200レスポンスを返すこと" do
				get :top
				expect(response).to have_http_status "200"
			end
		end
	end

	describe "#about" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :about
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :about
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do

			it "302レスポンスを返すこと" do
				get :about
				expect(response).to be_success
			end

			it "200レスポンスを返すこと" do
				get :about
				expect(response).to have_http_status "200"
			end
		end
	end

	describe "#show" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
				@event = FactoryBot.create(:event, user: @user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :show, params: { id: @user.id }
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :show, params: { id: @user.id }
				expect(response).to have_http_status "200"
			end
		end
		context "未ログインユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end

			it "302レスポンスを返すこと" do
				get :show, params: { id: @user.id }
				expect(response).to have_http_status "302"
			end

			it "ログイン画面にリダイレクトすること" do
				get :show, params: { id: @user.id }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end

	describe "#edit" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :edit, params: { id: @user.id }
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :edit, params: { id: @user.id }
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "302レスポンスを返すこと" do
				get :edit, params: { id: @user.id }
				expect(response).to have_http_status "302"
			end

			it "ログイン画面にリダイレクトすること" do
				get :edit, params: { id: @user.id }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end












	describe "#update" do
		context "認可されたユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "ユーザー情報を更新できること" do
				user_params = FactoryBot.attributes_for(:user, username: "New Username")
				sign_in @user
				patch :update, params: { id: @user.id, user: user_params }
				expect(@user.reload.username).to eq "New Username"
			end
		end
		context "認可されていないユーザーとして" do
			before do
				@user = FactoryBot.create(:user, username: "Default Name")
				@other_user = FactoryBot.create(:user)

			end
			it "ユーザー情報を更新できないこと" do
				user_params = FactoryBot.attributes_for(:user,
					username: "New Username")
				sign_in @other_user
				patch :update, params: { id: @user.id, user: user_params }
				expect(@user.reload.username).to eq "Default Name"
			end
			it "詳細画面にリダイレクトすること" do
				user_params = FactoryBot.attributes_for(:user)
				sign_in @other_user
				patch :update, params: { id: @user.id, user: user_params }
				expect(response).to redirect_to "/users/#{@other_user.id}"
			end
		end

		context "未ログインユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "302レスポンスを返すこと" do
				user_params = FactoryBot.attributes_for(:user)
				patch :update, params: { id: @user.id, user: user_params }
				expect(response).to have_http_status "302"
			end

			it "ログイン画面にリダイレクトすること" do
				user_params = FactoryBot.attributes_for(:user)
				patch :update, params: { id: @user.id, user: user_params }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end




	describe "#following" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :following, params: { id: @user.id }
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :following, params: { id: @user.id }
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "302レスポンスを返すこと" do
				get :edit, params: { id: @user.id }
				expect(response).to have_http_status "302"
			end
			it "ログイン画面にリダイレクトすること" do
				get :following, params: { id: @user.id }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end

	describe "#followers" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :followers, params: { id: @user.id }
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :followers, params: { id: @user.id }
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "302レスポンスを返すこと" do
				get :edit, params: { id: @user.id }
				expect(response).to have_http_status "302"
			end
			it "ログイン画面にリダイレクトすること" do
				get :followers, params: { id: @user.id }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end

end
