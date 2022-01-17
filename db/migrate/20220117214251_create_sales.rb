class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.integer :number_bill
      t.datetime :date

      t.timestamps
    end
  end
end
