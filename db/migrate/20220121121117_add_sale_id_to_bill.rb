class AddSaleIdToBill < ActiveRecord::Migration[7.0]
  def change
    add_reference :bills, :sale, null: false, foreign_key: true
  end
end
