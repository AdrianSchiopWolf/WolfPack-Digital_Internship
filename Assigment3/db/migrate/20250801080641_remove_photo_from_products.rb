class RemovePhotoFromProducts < ActiveRecord::Migration[7.1]
  def change
    remove_column :products, :photo, :string
  end
end
