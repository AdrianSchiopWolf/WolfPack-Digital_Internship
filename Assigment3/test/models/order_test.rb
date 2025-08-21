# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  total_amount :decimal(, )
#  created_at   :datetime
#  status       :integer          default("pending"), not null
#
require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
