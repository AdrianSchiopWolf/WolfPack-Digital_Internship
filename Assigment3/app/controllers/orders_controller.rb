# frozen_string_literal: true

class OrdersController < ApplicationController
  layout 'order_section'
  
  def index
    @orders = current_user.orders.includes(:order_items, order_items: :product).order(created_at: :desc)
  end
  
  def create
    cart_items = current_user.cart_items.includes(:product)

    if cart_items.empty?
      redirect_to shopping_cart_path, alert: 'Your cart is empty.'
      return
    end

    ActiveRecord::Base.transaction do
      order = current_user.orders.create!(
        total_amount: cart_items.sum { |item| item.product.price * item.quantity },
        status: 0
      )

      cart_items.each do |item|
        order.order_items.create!(
          product: item.product,
          quantity: item.quantity,
          price_at_purchase: item.product.price
        )
      end

      cart_items.destroy_all
    end

    redirect_to root_path, notice: 'Order created successfully.'
  rescue StandardError => e
    redirect_to shopping_cart_path, alert: "Failed to create order: #{e.message}"
  end

end
