# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, completed: 1, cancelled: 2 }
end
