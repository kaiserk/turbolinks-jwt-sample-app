class AddChargeIdToShops < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :shops, :charge_id, :string
  end
end
