require 'rails_helper'


RSpec.describe PassesController, type: :controller do
	let(:user) {create(:user)}
	let(:role) {create(:role)}
	let(:category) {create(:category)}
	let(:offer) {create(:offer)}
	let(:pass) {create(:pass, offer: offer, user: user, category: category)}
	let(:token) { JWT.encode({ user_id: user.id, exp: 1.hour.from_now.to_i }, 'hellomars1211') }
	
	before do 
		request.headers['Authorization'] = "Bearer #{token}"
	end 


	describe "GET #index" do
		context "when user is authorized" do
			it "returns a success response" do
			 	 get :index
				expect(response).not_to be_successful
			end
		end

		context "when user is not authorized" do 
			before do 
				request.headers['Authorization'] = nil
			end

			it "return errors " do 
				get :index
				expect(response).to have_http_status(:unauthorized)
				expect(JSON.parse(response.body)["message"]).to eq("Please log in")
			end
		end
	end

	describe "Get #show" do 
		context"When user is authorized" do  
			it "return a success response" do 
				get :show, params: { id: pass.id }
				expect(response).to be_successful
			end
		end
	end

	describe "post #create" do 
		context"when user authorized" do  
			it "create new pass" do
				post :create, params: { pass: { category_id: category.id, passenger_phone: "1234567890", passenger_email: "example@gmail.com", offer_id: offer.id , user_id: user.id} }
				expect(response.status).to eq(201)
			end
		end

		context"when user alredy has a pass" do  
			before do 
				user.pass = pass  
			end
			it "does not create a pass" do
				post :create, params: { pass: {category_id: category.id,  passenger_phone: "1234567890", passenger_email: "example@gmail.com", offer_id: offer.id } } 
				expect(response).not_to have_http_status(:unauthorized)
				expect(JSON.parse(response.body)["error"]).to eq("User already has a pass")
			end
		end

		context"When user is not authorized" do 
			before do 
				request.headers['Authorization'] = nil
			end

			it "retun 401 unauthorized response" do  
				post :create, params: { pass: { category_id: category.id, passenger_phone: "1234567890", passenger_email: "example@gmail.com", offer_id: offer.id } }
				expect(response).to have_http_status(:unauthorized)
				expect(JSON.parse(response.body)["message"]).to eq("Please log in")
			end
		end
	end

	describe "PUT #update" do 
		context "When user is authorized"do  
			it "updates the pass" do 
				new_phone = "0987654321"
        put :update, params: { id: pass.id, pass: { passenger_phone: new_phone } }
        pass.reload
        expect(response).to be_successful
        expect(JSON.parse(response.body)["message"]).to eq("Pass update successfully")
      end
      it "invalid params in update pass" do 
      	put :update, params: {id: pass.id, pass: {user_id: nil}}
      	expect(response).not_to be_successful
      	expect(JSON.parse(response.body)["user"]).to eq(["must exist"])
			end
		end

		context "when user unauthorized" do  
			before do 
				request.headers['Authorization'] = nil
			end

			it "return a 401 unauthorized response" do 
				put :update, params: {id: pass.id , pass: {passenger_phone: "741852963", passenger_email: "passenger74@gmail.com"}}
				expect(response).to have_http_status(:unauthorized)
				expect(JSON.parse(response.body)["message"]).to eq("Please log in")
			end
		end
	end
end
