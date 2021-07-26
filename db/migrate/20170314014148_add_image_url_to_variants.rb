class AddImageUrlToVariants < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :variants, :image_url, :text
  end
end
