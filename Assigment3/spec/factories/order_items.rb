# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    association :order
    association :product
    quantity { Faker::Number.between(from: 1, to: 3) }
    price_at_purchase { product.price }

    after(:build) do |order_item|
      order_item.price_at_purchase ||= order_item.product.price
    end
  end
end
