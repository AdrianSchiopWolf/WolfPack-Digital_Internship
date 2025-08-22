# frozen_string_literal: true

module Api
  module V1
    module Admin
      class OrdersController < Api::V1::Admin::BaseController
        # include Api::V1::Admin::OrdersControllerDoc

        before_action :set_order, only: [:update]

        # GET /api/v1/admin/orders
        def index
          orders = Order.includes(:user, order_items: :product).order(created_at: :desc)
          render json: Alba.serialize(orders, with: AdminOrderSerializer), status: :ok
        end

        # PATCH/PUT /api/v1/admin/orders/:id
        def update
          if @order.update(order_params)
            render json: Alba.serialize(@order, with: AdminOrderSerializer), status: :ok
          else
            render json: { error: 'Failed to update order', details: @order.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def set_order
          @order = Order.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Order not found' }, status: :not_found
        end

        def order_params
          params.permit(:status)
        end
      end
    end
  end
end
