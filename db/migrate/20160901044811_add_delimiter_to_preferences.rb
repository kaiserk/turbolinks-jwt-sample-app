class AddDelimiterToPreferences < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :preferences, :delimiter, :string, default: '.'
  end
end
