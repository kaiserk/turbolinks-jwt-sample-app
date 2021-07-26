class AddLabelTextToPreferences < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :preferences, :label_text, :string, default: 'Per Unit:'
  end
end
