class AddUnitNameToProducts < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :products, :unit_name, :string
  end
end
