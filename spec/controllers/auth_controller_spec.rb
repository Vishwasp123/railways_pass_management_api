require 'rails_helper'

RSpec.describe AuthController, type: :controller do

	describe "POST #login" do
		let(:user) {create(:user, password: "123456")}
    context "with valid credentials" do
      it "allows user login" do
        post :login, params: { auth: {username: user.username, password: user.password } }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to have_key('token')
      end

      it "invalid user params" do  
      	post :login, params: {auth: {username: user.username, password: nil}}
      	expect(response.body).to eq("{\"error\":\"Invalid username or password\"}")
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "destroy #logout" do
   let(:user) { create(:user) }
   let(:token) { JWT.encode({ user_id: user.id }, 'hellomars1211') }

  	context "with valid token" do
	  	before do 
	  	 request.headers['Authorization'] = "Bearer #{token}"
	  	end 
	 		it "logs out the user and blacklists the token" do
	      expect {
	        delete :logout
	      }.to change(BlacklistedToken, :count).by(1)
	      expect(response).to have_http_status(:ok)
	      expect(JSON.parse(response.body)).to eq({ "message" => "Logged out successfully" })
    	end
    end

    context "With invalid token" do 
    	before do 
	  	 request.headers['Authorization'] = nil
	  	end 
	    it "return an errors" do
	    	delete :logout
	    	expect(JSON.parse(response.body)["errors"]).to eq(nil	)
	    	expect(JSON.parse(response.body)).to eq("error" => "Token not provided")
	    end  
    end
	end
end
