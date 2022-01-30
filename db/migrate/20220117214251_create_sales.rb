class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.datetime :date

      t.timestamps
    end
  end
end
