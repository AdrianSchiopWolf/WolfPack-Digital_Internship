# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    association :user
    total_amount { 0 }
    status { 0 }

    after(:create) do |order|
      product = create(:product)
      create_list(:order_item, 2, order: order, product: product)
      order.update!(total_amount: order.order_items.sum { |item| item.price_at_purchase * item.quantity })
    end
  end
end
