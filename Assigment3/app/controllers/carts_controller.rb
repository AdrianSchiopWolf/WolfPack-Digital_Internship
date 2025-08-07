class CartsController < ApplicationController
  def index
  end

  def show
    @cart_items = current_user.cart_items.includes(:product)
  end

  def create
    product = Product.find(params[:product_id])
    @cart_item = current_user.cart_items.find_or_initialize_by(product: product)

    if @cart_item.save
      redirect_to root_path, notice: 'Item added to cart successfully.'
    else
      redirect_to root_path, alert: 'Failed to add item to cart.'
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
end
