require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  let(:admin_role) { create(:role, role_type: 'Admin') }
  let(:regular_role) { create(:role, role_type: 'User') }
  let(:admin_user) { create(:user, role: admin_role) }
  let(:regular_user) { create(:user, role: regular_role) }
  let(:user_new) { create(:user, username: "User2", role: regular_role) }
  let(:token) { JWT.encode({ user_id: user.id, exp: 1.hour.from_now.to_i }, 'hellomars1211') }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #report' do
    context 'when user is an admin' do
      let(:user) { admin_user }

      context 'when passes exist in the specified date range' do
        let!(:pass1) { create(:pass, issue_date: 3.days.ago, user: user_new) }
        let!(:pass2) { create(:pass, issue_date: 2.days.ago, user: user_new) }

        it 'returns the passes in the date range' do
          get :report
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['message']).to eq('Passes found')
          expect(JSON.parse(response.body)['passes'].count).to eq(2)
        end
      end

      context 'when no passes exist in the specified date range' do
        it 'returns a message indicating no passes found' do
          get :report
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body)['message']).to eq('No passes found in the specified date range')
        end
      end
    end

    context 'when user is not an admin' do
      let(:user) { regular_user }

      it 'returns an unauthorized error' do
        get :report
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)['message']).to eq('You are not authorized to view this report')
      end
    end
  end
end