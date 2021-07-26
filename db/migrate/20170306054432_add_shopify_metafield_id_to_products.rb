class AddShopifyMetafieldIdToProducts < ActiveRecord::Migration[4.2][4.2]
  def change
    add_column :products, :shopify_metafield_id, :string
  end
end
