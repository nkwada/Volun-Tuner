require 'rails_helper'

RSpec.describe EventsController, type: :controller do
	describe "#index" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :index
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :index
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do

			it "302レスポンスを返すこと" do
				get :index
				expect(response).to be_success
			end

			it "200レスポンスを返すこと" do
				get :index
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
				get :show, params: { id: @event.id }
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :show, params: { id: @event.id }
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
				other_user = FactoryBot.create(:user)
				@event = FactoryBot.create(:event, user: other_user)
			end

			it "302レスポンスを返すこと" do
				get :show, params: { id: @event.id }
				expect(response).to be_success
			end

			it "200レスポンスを返すこと" do
				get :show, params: { id: @event.id }
				expect(response).to have_http_status "200"
			end
		end
	end

	describe "#new" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :new
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :new
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do

			it "302レスポンスを返すこと" do
				get :new
				expect(response).to have_http_status "302"
			end

			it "ログイン画面にリダイレクトすること" do
				get :new
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end


	describe "#create" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "ボランティアを追加できること" do
				event_params = FactoryBot.attributes_for(:event)
				sign_in @user
				expect {
					post :create, params: { event: event_params }
				}.to change(@user.events, :count).by(1)
			end
		end
		context "未ログインユーザーとして" do
			it "302レスポンスを返すこと" do
				event_params = FactoryBot.attributes_for(:event)
				post :create, params: { event: event_params }
				expect(response).to have_http_status "302"
			end
			it "ログイン画面にリダイレクトすること" do
				event_params = FactoryBot.attributes_for(:event)
				post :create, params: { event: event_params }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end



	describe "#edit" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
				@event = FactoryBot.create(:event, user: @user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :edit, params: { id: @event.id }
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :edit, params: { id: @event.id }
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
				other_user = FactoryBot.create(:user)
				@event = FactoryBot.create(:event, user: other_user)
			end
			it "302レスポンスを返すこと" do
				get :edit, params: { id: @event.id }
				expect(response).to have_http_status "302"
			end

			it "ログイン画面にリダイレクトすること" do
				get :edit, params: { id: @event.id }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end

	describe "#update" do
		context "認可されたユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
				@event = FactoryBot.create(:event, user: @user)
			end
			it "ボランティアを更新できること" do
				event_params = FactoryBot.attributes_for(:event, title: "New Volunteer")
				sign_in @user
				patch :update, params: { id: @event.id, event: event_params }
				expect(@event.reload.title).to eq "New Volunteer"
			end
		end
		context "認可されていないユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
				other_user = FactoryBot.create(:user)
				@event = FactoryBot.create(:event,
					user: other_user,
					title: "Volunteer Name")
			end
			it "ボランティアを更新できないこと" do
				event_params = FactoryBot.attributes_for(:event,
					title: "New Name")
				sign_in @user
				patch :update, params: { id: @event.id, event: event_params }
				expect(@event.reload.title).to eq "Volunteer Name"
			end
			it "詳細画面にリダイレクトすること" do
				event_params = FactoryBot.attributes_for(:event)
				sign_in @user
				patch :update, params: { id: @event.id, event: event_params }
				expect(response).to redirect_to "/events/#{@event.id}"
			end
		end
		context "未ログインユーザーとして" do
			before do
				@event = FactoryBot.create(:event)
			end
			it "302レスポンスを返すこと" do
				event_params = FactoryBot.attributes_for(:event)
				patch :update, params: { id: @event.id, event: event_params }
				expect(response).to have_http_status "302"
			end

			it "ログイン画面にリダイレクトすること" do
				event_params = FactoryBot.attributes_for(:event)
				patch :update, params: { id: @event.id, event: event_params }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end


	describe "#destroy" do
		context "認可されたユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
				@event = FactoryBot.create(:event, user: @user)
			end
			it "ボランティアを削除できること" do
				sign_in @user
				expect {
					delete :destroy, params: { id: @event.id }
				}.to change(@user.events, :count).by(-1)
			end
		end
		context "認可されていないユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
				other_user = FactoryBot.create(:user)
				@event = FactoryBot.create(:event, user: other_user)
			end
			it "ボランティアを削除できないこと" do
				sign_in @user
				expect {
					delete :destroy, params: { id: @event.id }
				}.to_not change(Event, :count)
			end
			it "詳細画面にリダイレクトすること" do
				sign_in @user
				delete :destroy, params: { id: @event.id }
				expect(response).to redirect_to "/events/#{@event.id}"
			end
		end
		context "未ログインユーザーとして" do
			before do
				@event = FactoryBot.create(:event)
			end
			it "302レスポンスを返すこと" do
				delete :destroy, params: { id: @event.id }
				expect(response).to have_http_status "302"
			end

			it "ログイン画面にリダイレクトすること" do
				delete :destroy, params: { id: @event.id }
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end


	describe "#search_index" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :search_index
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :search_index
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do

			it "302レスポンスを返すこと" do
				get :search_index
				expect(response).to be_success
			end

			it "200レスポンスを返すこと" do
				get :search_index
				expect(response).to have_http_status "200"
			end
		end
	end

	describe "#pickup" do
		context "ログイン済みユーザーとして" do
			before do
				@user = FactoryBot.create(:user)
			end
			it "正常にレスポンスを返すこと" do
				sign_in @user
				get :pickup
				expect(response).to be_success
			end
			it "200レスポンスを返すこと" do
				sign_in @user
				get :pickup
				expect(response).to have_http_status "200"
			end
		end

		context "未ログインユーザーとして" do

			it "302レスポンスを返すこと" do
				get :pickup
				expect(response).to be_success
			end

			it "200レスポンスを返すこと" do
				get :pickup
				expect(response).to have_http_status "200"
			end
		end
	end
end
