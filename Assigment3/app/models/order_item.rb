# frozen_string_literal: true

# == Schema Information
#
# Table name: order_items
#
#  id                :integer          not null, primary key
#  order_id          :integer          not null
#  product_id        :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  quantity          :integer          default(1), not null
#  price_at_purchase :decimal(10, 2)   default(0.0), not null
#
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
end
