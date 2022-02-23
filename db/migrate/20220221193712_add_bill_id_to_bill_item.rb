class AddBillIdToBillItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :bill_items, :bill, null: false, foreign_key: true
  end
end