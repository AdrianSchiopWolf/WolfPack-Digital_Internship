# frozen_string_literal: true

class OrderSerializer
  include Alba::Resource

  attributes :id, :total_amount, :status, :created_at

  many :order_items, resource: OrderItemSerializer
end
