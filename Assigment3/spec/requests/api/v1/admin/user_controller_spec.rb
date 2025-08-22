# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::UsersController, type: :request do
  let!(:user) { create(:user, :admin) }
  let!(:token) { auth_tokens(user.id) }
  describe 'GET /api/v1/admin/users' do
    subject(:perform_request) do
      get api_v1_admin_users_path,
          headers: { **common_headers, **auth_headers(token[:access_token]) }
    end

    context 'with existing users' do
      let!(:users) { create_list(:user, 3) }

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns the list of users' do
        perform_request
        expect(response_json).to include({
                                           id: users.second.id,
                                           email: users.second.email,
                                           username: users.second.username
                                         })
      end
    end

    context 'without other existing users' do
      it 'returns the current user' do
        perform_request
        expect(response_json).to include({
                                           id: user.id,
                                           email: user.email,
                                           username: user.username
                                         })
      end
    end
  end
end
