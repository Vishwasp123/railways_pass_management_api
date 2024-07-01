require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:admin_role) { create(:role, role_type: 'Admin') }
  let(:regular_role) { create(:role, role_type: 'User') }
  let(:admin_user) { create(:user, role: admin_role) }
  let(:regular_user) { create(:user, role: regular_role) }
  let(:token) { JWT.encode({ user_id: user.id, exp: 1.hour.from_now.to_i }, 'hellomars1211') }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
    allow(controller).to receive(:authorized).and_return(true)  # Mocking the authorized method
  end

  describe 'POST #create_about_us' do
    context 'when user is an admin' do
      let(:user) { admin_user }
      let(:valid_params) { { about_u: { title: 'About Us', description: 'This is a description', customer_support_contact: '1234567890', headquaters_address: '123 Main St', email_address: 'info@example.com' } } }

      it 'creates a new about us' do
        expect {
          post :create_about_us, params: valid_params
        }.to change(AboutU, :count).by(1)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not an admin' do
      let(:user) { regular_user }

      it 'returns unauthorized error' do
        post :create_about_us
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'PUT #update_about_us' do
    context 'when user is an admin' do
      let(:user) { admin_user }
      let(:about_us) { create(:about_u) }
      let(:valid_params) { { id: about_us.id, about_u: { title: 'Updated About Us' } } }

      it 'updates the about us' do
        put :update_about_us, params: valid_params
        about_us.reload
        expect(response).to have_http_status(:success)
        expect(about_us.title).to eq('Updated About Us')
      end
    end

    context 'when user is not an admin' do
      let(:user) { regular_user }
      let(:about_us) { create(:about_u) }

      it 'returns unauthorized error' do
        put :update_about_us, params: { id: about_us.id }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'POST #create_contact_us' do
    context 'when user is an admin' do
      let(:user) { admin_user }
      let(:valid_params) { { contact_u: { name: 'John Doe', email: 'john@example.com', phone_number: '1234567890', message: 'Test message' } } }

      it 'creates a new contact us' do
        expect {
          post :create_contact_us, params: valid_params
        }.to change(ContactU, :count).by(1)
        expect(response).to have_http_status(:success)
      end
    end

    context 'when user is not an admin' do
      let(:user) { regular_user }

      it 'returns unauthorized error' do
        post :create_contact_us
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('You are not authorized to perform this action')
      end
    end
  end

  describe 'PUT #update_contact_us' do
    context 'when user is an admin' do
      let(:user) { admin_user }
      let(:contact_us) { create(:contact_u) }
      let(:valid_params) { { id: contact_us.id, contact_u: { name: 'Updated Name' } } }

      it 'updates the contact us' do
        put :update_contact_us, params: valid_params
        contact_us.reload
        expect(response).to have_http_status(:success)
        expect(contact_us.name).to eq('Updated Name')
      end
    end

    context 'when user is not an admin' do
      let(:user) { regular_user }
      let(:contact_us) { create(:contact_u) }

      it 'returns unauthorized error' do
        put :update_contact_us, params: { id: contact_us.id }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['error']).to eq('You are not authorized to perform this action')
      end
    end
  end
end
