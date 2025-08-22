# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  product_id    :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  quantity      :integer          default(1), not null
#
class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product
end
