# frozen_string_literal: true

class ChangeOrdersStatusToInteger < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :status, :string
    add_column :orders, :status, :integer, default: 0, null: false
  end
end
