class ChangeDefaultValueOfThemeScoping < ActiveRecord::Migration[4.2][4.2]
  def change
    change_column_default(:shops, :theme_scope_enabled, true)
  end
end
