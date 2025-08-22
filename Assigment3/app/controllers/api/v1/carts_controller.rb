# frozen_string_literal: true

module Api
  module V1
    module Api
      module V1
        class CartsController < Api::V1::BaseController
          # include Api::V1::CartsControllerDoc

          def index
            cart_items = current_user.cart_items.includes(:product)
            render json: cart_items.map { |item| CartItemSerializer.new(item) }, status: :ok
          end

          def show
            cart_item = current_user.cart_items.includes(:product).find_by(id: params[:id])
            if cart_item
              render json: CartItemSerializer.new(cart_item), status: :ok
            else
              render json: { error: 'Cart item not found' }, status: :not_found
            end
          end

          def create
            product = Product.find_by(id: params[:product_id])
            unless product
              render json: { error: 'Product not found' }, status: :not_found
              return
            end

            cart_item = current_user.cart_items.find_or_initialize_by(product: product)

            if cart_item.save
              render json: Alba.serialize(cart_item), status: :created
            else
              render json: { error: 'Failed to add item to cart', details: cart_item.errors.full_messages }, status: :unprocessable_entity
            end
          end

          def destroy
            cart_item = current_user.cart_items.find_by(id: params[:id])
            if cart_item&.destroy
              render json: { message: 'Item removed from cart' }, status: :ok
            else
              render json: { error: 'Cart item not found or failed to remove' }, status: :not_found
            end
          end

          def update_quantity
            cart_item = current_user.cart_items.find_by(id: params[:id])
            unless cart_item
              render json: { error: 'Cart item not found' }, status: :not_found
              return
            end

            unless params[:quantity].present? && params[:quantity].to_i >= 0
              render json: { error: 'Invalid quantity' }, status: :unprocessable_entity
              return
            end

            new_quantity = params[:quantity].to_i

            if new_quantity.positive?
              cart_item.update(quantity: new_quantity)
              render json: CartItemSerializer.new(cart_item), status: :ok
            else
              cart_item.destroy
              render json: { message: 'Item removed from cart' }, status: :ok
            end
          end
        end
      end
    end
  end
end
