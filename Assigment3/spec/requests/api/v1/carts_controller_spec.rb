require 'rails_helper'

RSpec.describe Api::V1::CartsController, type: :request do
  let(:user) { create(:user) }
  let(:token) { auth_tokens(user.id) }
  let(:headers) { { **common_headers, **auth_headers(token[:access_token]) } }
  
  describe "GET /api/v1/carts" do
    subject(:perform_request) do
      get api_v1_carts_path,
      headers: headers
    end

    context "with existing cart items" do
      let!(:cart_items) { create_list(:cart_item, 3 , user: user) }

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns the cart details' do
        perform_request
        request_ids = response_json.map { |item| item[:id] }
        expect(request_ids).to match_array(cart_items.map(&:id))
      end
    end

    context "without existing cart items" do
      it 'returns an empty cart' do
        perform_request
        expect(response_json).to eq([])
      end
    end
  end

  describe "POST /api/v1/carts" do
    subject(:perform_request) do
      post api_v1_carts_path,
      headers: headers,
      params: params.to_json
    end

    context "with valid parameters" do
      let(:params) do
      { 
        product_id: create(:product).id, 
      }
      end

      it 'creates a new cart' do
        expect { perform_request }.to change(CartItem, :count).by(1)
      end

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:created)
      end

      it 'returns the created cart details' do
        perform_request
        response_cart_item_id = response_json[:id]
        expect(response_cart_item_id).to eq(1)
      end
    end

    context "with invalid parameters" do
      let(:params) do
      { 
        product_id: nil, 
      }
      end

      it 'does not create a new cart' do
        expect { perform_request }.not_to change(CartItem, :count)
      end

      it 'returns an unprocessable entity status' do
        perform_request
        expect(response).to have_http_status(404)
      end

      it 'returns the error details' do
        perform_request
        expect(response_json).to include(:error)
      end
    end
  end

  describe "DELETE /api/v1/carts/:id" do
    subject(:perform_request) do
      delete api_v1_cart_path(id),
      headers: headers
    end

    context "with existing cart item" do
      let!(:cart_item) { create(:cart_item, user: user) }
      let(:id) { cart_item.id }

      it 'deletes the cart item' do
        expect { perform_request }.to change(CartItem, :count).by(-1)
      end

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:ok)
      end
    end

    context "with non-existing cart item" do
      let(:id) { 999 }

      it 'does not delete any cart item' do
        expect { perform_request }.not_to change(CartItem, :count)
      end

      it 'returns a not found status' do
        perform_request
        expect(response).to have_http_status(:not_found)
      end

      it 'returns the error details' do
        perform_request
        expect(response_json).to include(:error)
      end
    end
  end

  describe "PATCH /api/v1/carts/:id/update_quantity" do
    subject(:perform_request) do
      patch update_quantity_api_v1_cart_path(id),
      headers: headers,
      params: params.to_json
    end

    context "with valid parameters" do
      let(:cart_item) { create(:cart_item, user: user) }
      let(:id) { cart_item.id }
      let(:params) do
        {
          quantity: 2
        }
      end

      it 'updates the cart item quantity' do
        perform_request
        expect(cart_item.reload.quantity).to eq(2)
      end

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated cart item details' do
        perform_request
        expect(response_json[:id]).to eq(cart_item.id)
        expect(response_json[:quantity]).to eq(2)
      end
    end

    context "with invalid parameters" do
      let(:cart_item) { create(:cart_item, user: user) }
      let(:id) { cart_item.id }
      let(:params) do
        {
          quantity: nil
        }
      end

      it 'does not update the cart item' do
        perform_request
        expect(cart_item.reload.quantity).to eq(1)
      end

      it 'returns an unprocessable entity status' do
        perform_request
        expect(response).to have_http_status(422)
      end

      it 'returns the error details' do
        perform_request
        expect(response_json).to include(:error)
      end
    end
  end
end