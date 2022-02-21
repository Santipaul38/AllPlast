class AddSaleDetailIdToBillItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :bill_items, :sale_detail, null: false, foreign_key: true
  end
end
