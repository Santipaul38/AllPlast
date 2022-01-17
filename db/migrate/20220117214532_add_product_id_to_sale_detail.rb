class AddProductIdToSaleDetail < ActiveRecord::Migration[7.0]
  def change
    add_reference :sale_details, :product, null: false, foreign_key: true
  end
end
