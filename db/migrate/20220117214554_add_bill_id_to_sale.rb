class AddBillIdToSale < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :bill, null: false, foreign_key: true
  end
end
