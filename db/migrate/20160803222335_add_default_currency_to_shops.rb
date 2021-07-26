class AddDefaultCurrencyToShops < ActiveRecord::Migration[4.2][4.2]
  def change
    change_column_default(:preferences, :currency, '$')
  end
end
