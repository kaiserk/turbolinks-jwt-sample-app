class AddCollectionLabelTextToPreferences < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :preferences, :collection_label_text, :string, default: 'Click here for more details'
  end
end
