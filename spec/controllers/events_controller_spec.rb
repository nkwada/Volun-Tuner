require 'rails_helper'

RSpec.describe EventsController, type: :controller do
	describe "#new" do
		# 認証済みのユーザーとして
		context "as an authenticated user" do
			before do
				@user = FactoryBot.create(:user)
			end
			# 正常にレスポンスを返すこと
			it "responds successfully" do
				sign_in @user
				get :new
				expect(response).to be_success
			end
			# 200レスポンスを返すこと
			it "returns a 200 response" do
				sign_in @user
				get :new
				expect(response).to have_http_status "200"
			end
		end
		# ゲストとして
		context "as a guest" do
			# 302レスポンスを返すこと
			it "returns a 302 response" do
				get :new
				expect(response).to have_http_status "302"
			end
				# サインイン画面にリダイレクトすること

			it "redirects to the sign-in page" do
				get :new
				expect(response).to redirect_to "/users/sign_in"
			end
		end
	end
end
