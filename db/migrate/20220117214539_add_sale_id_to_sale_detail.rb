class AddSaleIdToSaleDetail < ActiveRecord::Migration[7.0]
  def change
    add_reference :sale_details, :sale, null: false, foreign_key: true
  end
end
