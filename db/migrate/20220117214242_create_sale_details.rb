class CreateSaleDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_details do |t|
      t.integer :unit
      t.float :import

      t.timestamps
    end
  end
end
