class CreateBillItems < ActiveRecord::Migration[7.0]
  def change
    create_table :bill_items do |t|

      t.timestamps
    end
  end
end
