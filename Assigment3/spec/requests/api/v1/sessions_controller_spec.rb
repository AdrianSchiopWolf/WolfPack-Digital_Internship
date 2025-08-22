require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do
  describe 'POST /api/v1/sessions' do
    subject(:perform_request) { post api_v1_sessions_path, params: params.to_json, headers: common_headers }

    context 'with valid params' do
      let!(:user) { create(:user) }
      let!(:params) do
        {
          email: user.email,
          password: user.password
        }
      end

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns the access token' do
        perform_request
        expect(response_json[:tokens]).to be_present
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          email: 'invalid@example.com',
          password: 'wrongpassword'
        }
      end

      it 'returns an unprocessable entity status' do
        perform_request
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        perform_request
        expect(response_json[:errors]).to be_present
      end
    end
  end

  describe 'DELETE /api/v1/sessions' do
    subject(:perform_request) do
      delete api_v1_sessions_path, 
      headers: headers
    end

    context 'with valid token' do
      let(:headers)  {{ **common_headers, **auth_headers(token[:access_token]) }}
      let!(:user) { create(:user) }
      let!(:token) { auth_tokens(user.id) }



      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:ok)
      end

      it 'revokes the access token' do
        perform_request
        expect(response_json[:message]).to eq('Logged out successfully')
      end
    end

    context 'with invalid token' do
      let(:headers) { { 'Authorization' => 'Bearer invalid_token' } }

      it 'returns an unauthorized status' do
        perform_request
        expect(response).to have_http_status(401)
      end
    end
  end
end