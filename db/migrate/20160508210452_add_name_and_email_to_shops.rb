class AddNameAndEmailToShops < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :shops, :first_name, :string
    add_column :shops, :last_name, :string
    add_column :shops, :email_address, :string
  end
end
