# frozen_string_literal: true

class AdminOrderSerializer
  include Alba::Resource

  attributes :id, :total_amount, :status, :created_at

  attribute :user do
    {
      id: object.user.id,
      username: object.user.username,
      email: object.user.email
    }
  end

  many :order_items, resource: OrderItemSerializer
end
