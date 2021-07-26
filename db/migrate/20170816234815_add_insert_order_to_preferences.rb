class AddInsertOrderToPreferences < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :preferences, :insert_order, :string
  end
end
