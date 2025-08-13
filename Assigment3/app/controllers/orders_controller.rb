class OrdersController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      cart_items = current_user.cart_items.includes(:product)
      if cart_items.empty?
        redirect_to cart_path, alert: 'Your cart is empty.'
        return
      end

      order = current_user.orders.create!(
        total_amount: cart_items.sum { |item| item.product.price * item.quantity },
        status: 'pending'
      )

      cart_items.each do |item|
        order.order_items.create!(
          product: item.product,
          total_price: item.product.price * item.quantity
        )
      end
      
      cart_items.destroy_all

      redirect_to order_path(order), notice: 'Order created successfully.'
    end
  rescue => e
      redirect_to cart_path, alert: "Failed to create order: #{e.message}"
  end
  
end