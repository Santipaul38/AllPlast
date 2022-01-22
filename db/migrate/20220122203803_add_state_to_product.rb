class AddStateToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :state, :integer
  end
end
