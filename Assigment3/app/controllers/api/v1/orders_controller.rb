class Api::V1::OrdersController < Api::V1::BaseController

  # GET /api/v1/orders
  def index
    orders = current_user.orders.includes(:order_items, order_items: :product).order(created_at: :desc)
    render json: Alba.serialize(orders, with: OrderSerializer), status: :ok
  end

  # POST /api/v1/orders
  def create
    cart_items = current_user.cart_items.includes(:product)

    if cart_items.empty?
      render json: { error: 'Your cart is empty.' }, status: :unprocessable_entity
      return
    end

    order = nil

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

    render json: Alba.serialize(order, with: OrderSerializer), status: :created
  rescue StandardError => e
    render json: { error: "Failed to create order: #{e.message}" }, status: :unprocessable_entity
  end
end