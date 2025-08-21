class DeleteCurrentPriceFromCart < ActiveRecord::Migration[7.1]
  def change
        remove_column :carts, :current_price, :decimal
  end
end
