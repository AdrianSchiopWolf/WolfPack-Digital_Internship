# frozen_string_literal: true

class AddQuantityToCarts < ActiveRecord::Migration[7.1]
  def change
    add_column :carts, :quantity, :integer
  end
end
