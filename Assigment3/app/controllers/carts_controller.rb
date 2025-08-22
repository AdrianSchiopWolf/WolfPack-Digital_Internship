# frozen_string_literal: true

class CartsController < ApplicationController
  def index; end

  def show
    @cart_items = current_user.cart_items.includes(:product)
  end

  # POST /api/v1/cart
  def create
    product = Product.find_by(id: params[:product_id])

    unless product
      render json: { error: 'Product not found' }, status: :not_found
      return
    end

    cart_item = current_user.cart_items.find_or_initialize_by(product: product)

    if cart_item.save
      render json: CartItemSerializer.new(cart_item), status: :created
    else
      render json: { error: 'Failed to add item to cart', details: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    cart_item = current_user.cart_items.find(params[:id])
    if cart_item.destroy
      redirect_to root_path, notice: 'Item removed from cart successfully.'
    else
      redirect_to root_path, alert: 'Failed to remove item from cart.'
    end
  end

  def update_quantity
    cart_item = current_user.cart_items.find(params[:id])
    return redirect_to cart_path(cart_item), alert: 'Item not found.' unless cart_item

    # Ensure the quantity is a valid integer
    return redirect_to cart_path(cart_item), alert: 'Invalid quantity.' unless params[:quantity].present?

    new_quantity = params[:quantity].to_i

    if new_quantity.positive?
      cart_item.update(quantity: new_quantity)
      redirect_back fallback_location: cart_path(cart_item), notice: 'Quantity updated.'
    else
      cart_item.destroy
      redirect_back fallback_location: cart_path(cart_item), notice: 'Item removed from cart.'
    end
  end
end
