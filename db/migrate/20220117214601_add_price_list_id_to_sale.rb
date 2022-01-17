class AddPriceListIdToSale < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :price_list, null: false, foreign_key: true
  end
end
