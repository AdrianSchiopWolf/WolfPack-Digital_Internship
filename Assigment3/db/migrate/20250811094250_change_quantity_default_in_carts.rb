# frozen_string_literal: true

class ChangeQuantityDefaultInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :carts, :quantity, 1
    change_column_null :carts, :quantity, false, 1
  end
end
