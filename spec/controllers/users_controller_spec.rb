require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	let(:user) {create(:user, username: "testuser1", password: "123456")}
	let(:invalid_user) {create(:user, username: nil)}


	describe "Post #create" do 
		context "user create valid" do 
			it "create user" do
			post :create, params:{ user: {username: "username1", password: "123456", role_id: user.role_id } }  
			expect(JSON.parse(response.body)).to have_key('token')  
			end
		end 
	end

	describe "Show #user" do 
		let(:token) { JWT.encode({ user_id: user.id }, 'hellomars1211') }
		context "user show data" do
			it "show user data " do 
				request.headers['Authorization'] = "Bearer #{token}"
				get :show
				expect(response).to have_http_status(:ok)
			end
		end
	end
end
