class AddMaxStockToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :max_stock, :integer
  end
end
