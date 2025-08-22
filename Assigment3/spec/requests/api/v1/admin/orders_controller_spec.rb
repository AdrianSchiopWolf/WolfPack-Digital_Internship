require 'rails_helper'

RSpec.describe Api::V1::Admin::OrdersController, type: :request do
  let(:admin_user) { create(:user, :admin) }
  let(:token) { auth_tokens(admin_user.id) }
  let(:headers) { { **common_headers, **auth_headers(token[:access_token]) } }
  
  describe 'GET /api/v1/admin/orders' do
    subject(:perform_request) do
      get api_v1_admin_orders_path,
      headers: headers
    end


    context "with existing orders" do

      let!(:orders) { create_list(:order, 3) }

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns the list of orders' do
        perform_request
        returned_ids = response_json.map { |o| o[:id] }
        expect(returned_ids).to match_array(orders.map(&:id))
      end
    end

    context "without other existing orders" do
      it 'returns the current user' do
        perform_request
        expect(response_json).to eq([])
      end
    end
  end

  describe "PATCH /api/v1/admin/orders/:id" do
    subject(:perform_request) do
      patch api_v1_admin_order_path(order),
      headers: headers,
      params: params.to_json
    end
    
    context "with existing order" do
      let!(:order) { create(:order) }
      let(:params) { { status: 'cancelled' } }

      it "updates the order status" do
        perform_request
        expect(order.reload.status).to eq('cancelled')
      end

      it "returns a success response" do
        perform_request
        expect(response).to have_http_status(:ok)
      end
    end
  end
end