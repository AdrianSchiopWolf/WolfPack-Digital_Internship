# frozen_string_literal: true

module Admin
  class OrdersController < Admin::BaseController
    layout 'order_section'
    def index
      @orders = Order.all.includes(:user, order_items: :product).order(created_at: :desc)
      render 'orders/index'
    end

    def update
      @order = Order.find(params[:id])
      if @order.update(order_params)
        redirect_to admin_orders_path, notice: 'Order updated successfully.'
      else
        flash.now[:alert] = 'Failed to update order.'
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def order_params
      params.require(:order).permit(:status)
    end
  end
end
