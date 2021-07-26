class AddThemeAccessToShops < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :shops, :theme_scope_enabled, :boolean, default: false
  end
end
