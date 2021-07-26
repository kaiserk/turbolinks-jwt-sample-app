class AddVariantLabelTextToPreferences < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :preferences, :variant_label_text, :string
  end
end
