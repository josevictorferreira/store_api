class AddIndexesToStockItems < ActiveRecord::Migration[6.0]
  def change
    add_index :stock_items, [:product_id, :store_id], unique: true
  end
end
