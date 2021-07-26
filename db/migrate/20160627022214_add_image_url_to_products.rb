class AddImageUrlToProducts < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :products, :image_url, :text
  end
end
