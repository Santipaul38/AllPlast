class AddDateToBill < ActiveRecord::Migration[7.0]
  def change
    add_column :bills, :date, :datetime
  end
end
