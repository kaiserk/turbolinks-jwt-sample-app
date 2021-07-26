class RenameExternalObjectIds < ActiveRecord::Migration[4.2][4.2]
  def change
    rename_column :products, :shopify_product_id, :shopify_id
    rename_column :variants, :shopify_variant_id, :shopify_id
  end
end
