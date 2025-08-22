require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  let(:user) { create(:user) }
  let(:token) { auth_tokens(user.id) }
  
  describe 'GET /api/v1/products' do
    subject(:perform_request) do
      get api_v1_products_path, 
      headers: { **common_headers, **auth_headers(token[:access_token]) }
    end

    let!(:products) { create_list(:product, 3) }
    it 'returns a success status' do
      perform_request
      expect(response).to have_http_status(:ok)
    end

    it 'returns all products' do
      perform_request
      expect(response_json.length).to eq(3)
    end

    it 'returns product attributes' do
      perform_request
      expect(response_json.first).to include(
        :id,
        :name,
        :category,
        :price,
      )
    end
  end
end