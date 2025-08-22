require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST /api/v1/users' do
    subject(:perform_request) { post api_v1_users_path, params: params.to_json, headers: common_headers }

    context 'with valid params' do
      let(:params) do
        {
          username: Faker::Internet.unique.username,
          email: Faker::Internet.unique.email,
          password: 'Password1@',
          password_confirmation: 'Password1@'
        }
      end

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:created)
      end

      it 'creates a new user' do
        expect { perform_request }.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          username: Faker::Internet.unique.username,
          email: Faker::Internet.unique.email,
          password: 'short',
          password_confirmation: 'mismatch'
        }
      end

      it 'returns an unprocessable entity for password mismatch' do
        perform_request
        expect(response).to have_http_status(422)
      end

      it 'returns error messages' do
        perform_request
        expect(response_json[:errors]).to be_present
      end

      it 'returns an unprocessable entity for invalid email format' do

        params[:email] = 'invalid-email'

        perform_request
        expect(response).to have_http_status(422)
      end
    end
  end
end
