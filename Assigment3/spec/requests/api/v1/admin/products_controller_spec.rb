# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::Admin::ProductsController, type: :request do
  let!(:user) { create(:user, :admin) }
  let!(:token) { auth_tokens(user.id) }
  describe 'POST /api/v1/admin/products' do
    subject(:perform_request) do
      post api_v1_admin_products_path,
           headers: { **common_headers, **auth_headers(token[:access_token]) },
           params: params.to_json
    end

    context 'with valid parameters' do
      let(:params) do
        {
          name: Faker::Commerce.unique.product_name,
          category: %w[Entrees Salads].sample,
          price: Faker::Commerce.price(range: 0..100.0)
        }
      end

      it 'creates a new product' do
        expect { perform_request }.to change(Product, :count).by(1)
      end

      it 'returns a success status' do
        perform_request
        expect(response).to have_http_status(:created)
      end

      it 'returns the created product' do
        perform_request
        expect(response_json).to include(
          id: Product.last.id,
          photo_url: nil,
          name: params[:name],
          category: params[:category],
          price: params[:price].to_s
        )
      end
    end
    context 'with invalid parameters' do
      let(:params) { { name: '', category: '', price: -1 } }

      it 'does not create a new product' do
        expect { perform_request }.not_to change(Product, :count)
      end

      it 'returns a unprocessable entity status' do
        perform_request
        expect(response).to have_http_status(422)
      end

      it 'returns the errors' do
        perform_request
        expect(response_json).to include(
          errors: [
            "Name can't be blank",
            'Price must be greater than or equal to 0',
            "Category can't be blank"
          ]
        )
      end
    end
  end

  describe 'DELETE /api/v1/admin/products/:id' do
    subject(:perform_request) do
      delete api_v1_admin_product_path(product_id),
             headers: { **common_headers, **auth_headers(token[:access_token]) }
    end

    let!(:product) { create(:product) }
    context 'with existing product' do
      let(:product_id) { product.id }

      it 'deletes the product' do
        expect { perform_request }.to change(Product, :count).by(-1)
      end

      it 'returns a no content status' do
        perform_request
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'without existing product' do
      let!(:product_id) { Product.maximum(:id).to_i + 1 }

      it 'does not delete any product' do
        expect { perform_request }.not_to change(Product, :count)
      end

      it 'returns a not found status' do
        perform_request
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
