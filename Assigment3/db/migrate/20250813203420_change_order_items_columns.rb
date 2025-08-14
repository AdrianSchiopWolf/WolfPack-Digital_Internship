# frozen_string_literal: true

class ChangeOrderItemsColumns < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_items, :total_price, :decimal

    # Add the new columns
    add_column :order_items, :quantity, :integer, null: false, default: 1
    add_column :order_items, :price_at_purchase, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
