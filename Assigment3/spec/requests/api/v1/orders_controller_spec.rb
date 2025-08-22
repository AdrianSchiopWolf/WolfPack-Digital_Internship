require "rails_helper"

RSpec.describe Api::V1::OrdersController, type: :request do
  let(:user) { create(:user) }
  let(:token) { auth_tokens(user.id) }
  let(:headers) { { **common_headers, **auth_headers(token[:access_token]) } }

  describe "GET /api/v1/orders" do
    subject(:perform_request) do
      get api_v1_orders_path,
      headers: headers
    end

    context "with existing orders" do
      let!(:orders) { create_list(:order, 3, user: user) }

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns the order details' do
        perform_request
        request_ids = response_json.map { |item| item[:id] }
        expect(request_ids).to match_array(orders.map(&:id))
      end
    end

    context "without existing orders" do
      it 'returns an empty array' do
        perform_request
        expect(response_json).to eq([])
      end
    end 
  end

  describe "POST /api/v1/orders" do
    subject(:perform_request) do
      post api_v1_orders_path,
      headers: headers
    end

    context "when cart has items" do
      let!(:product1) { create(:product, price: 10) }
      let!(:product2) { create(:product, price: 20) }
      let!(:cart_item1) { create(:cart_item, user: user, product: product1, quantity: 2) }
      let!(:cart_item2) { create(:cart_item, user: user, product: product2, quantity: 1) }

      it "returns created status" do
        perform_request
        expect(response).to have_http_status(:created)
      end

      it "creates an order" do
        expect { perform_request }.to change(Order, :count).by(1)
      end

      it "assigns the order to the user" do
        perform_request
        expect(Order.last.user).to eq(user)
      end

      it "calculates the correct total amount" do
        perform_request
        expect(Order.last.total_amount).to eq(40) # (2×10) + (1×20)
      end

      it "creates order items from cart items" do
        perform_request
        expect(Order.last.order_items.count).to eq(2)
      end

      it "clears the cart after checkout" do
        perform_request
        expect(user.cart_items.count).to eq(0)
      end
    end

    context "when cart is empty" do
      it "does not create an order" do
        expect { perform_request }.not_to change(Order, :count)
      end

      it "returns an error status" do
        perform_request
        expect(response).to have_http_status(422)
      end

      it "returns an error message" do
        perform_request
        expect(response_json[:error]).to eq("Your cart is empty.")
      end
    end

    context "when something goes wrong" do
      before do
        allow_any_instance_of(OrderItem).to receive(:save!).and_raise(StandardError, "DB error")
      end

      let!(:product) { create(:product, price: 15) }
      let!(:cart_item) { create(:cart_item, user: user, product: product, quantity: 1) }

      it "does not create an order" do
        expect { perform_request }.not_to change(Order, :count)
      end

      it "returns an error status" do
        perform_request
        expect(response).to have_http_status(422)
      end

      it "returns a failure message" do
        perform_request
        expect(response_json[:error]).to match(/Failed to create order/)
      end
    end
  end
end