# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  product_id    :integer          not null
#  current_price :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  quantity      :integer          default(1), not null
#
require 'test_helper'

class CartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
