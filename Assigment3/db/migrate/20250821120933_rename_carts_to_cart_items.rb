# frozen_string_literal: true

class RenameCartsToCartItems < ActiveRecord::Migration[7.1]
  def change
    rename_table :carts, :cart_items
  end
end
