class CreatePriceLists < ActiveRecord::Migration[7.0]
  def change
    create_table :price_lists do |t|
      t.datetime :date
      t.float :percentage
      t.datetime :expiration_date

      t.timestamps
    end
  end
end
