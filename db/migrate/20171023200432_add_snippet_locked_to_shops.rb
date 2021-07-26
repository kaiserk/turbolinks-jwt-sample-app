class AddSnippetLockedToShops < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :shops, :snippet_locked, :boolean, default: false
  end
end
