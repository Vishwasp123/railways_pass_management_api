require 'rails_helper'

RSpec.describe EnquiryController, type: :controller do 
	let(:admin_role) {create(:role, role_type: "Admin")}
	let(:admin_user) {create(:user, role: admin_role)}
	let(:regular_user) {create(:user)}
	let(:enquiry) {create(:enquiry, name:regular_user.username)}
	let(:token) { JWT.encode({ user_id: user.id, exp: 1.hour.from_now.to_i }, 'hellomars1211') }
	let(:admin_user_role) {create(:user, username: "User2", role: role)}
	let(:admin_token) { JWT.encode({ user_id: admin_user_role.id, exp: 1.hour.from_now.to_i }, 'hellomars1211') }


	before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'Get #index' do 
  	context 'when user is an admin' do 
  		let(:user) { admin_user }
  		it 'returns all enquiries' do
        get :index
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)['enquiry'].count).to eq(Enquiry.count)
      end
    end
    context "when user is not admin" do 
    	let(:user) {regular_user}
    	it "return user unauthorized" do
	    	get :index
	    	expect(response).to have_http_status(:unauthorized)
	    	expect(JSON.parse(response.body)['error']).to eq('You are not authorized to perform this action')
    	end
    end
  end

  describe "Get #show" do 
  	let(:user) {regular_user}
  	it 'returns the enquiry details' do
      get :show, params: { id: enquiry.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['enquiry']['id']).to eq(enquiry.id)
    end
  end

  describe "Post #create" do 
  	context 'when a user create enquiry' do 
  		let(:user) {regular_user}
  		it "craete user" do 
  			request.headers['Authorization'] = "Bearer #{token}"
  			post :create, params: { enquiry: { name: enquiry.name, email: enquiry.email, message: enquiry.message } }
  			expect(response).to have_http_status(:success)
  		end
  	end
  end

  describe "Put #update" do 
  	context 'when user is user' do 
  		let(:user) {regular_user}
	  	it "updates enquiry message" do
	      request.headers['Authorization'] = "Bearer #{token}"
      put :update, params: { id: enquiry.id, enquiry: { message: "hii new message" } }     
	      enquiry.reload
	      expect(response).to have_http_status(:success)
   	 end
  	end
  	context "when a user admin" do 
	  	let(:role) {create(:role, role_type: "Admin")}
	  	let(:admin_user_role) {create(:user, username: "User2", role: role)}
	  	let(:token) { JWT.encode({ user_id: admin_user_role.id, exp: 1.hour.from_now.to_i }, 'hellomars1211') }

  		it "return false user is admin" do
  			admin_user_role
  			request.headers['Authorization'] = "Bearer #{admin_token}"
  			put :update, params: { id: enquiry.id, enquiry: { subject: 'New Subject' } }
  			expect(response).to have_http_status(:unauthorized)
  			expect(JSON.parse(response.body)['error']).to eq('You are not  user authorized to perform this action')			
  		end
  	end
  end
end

