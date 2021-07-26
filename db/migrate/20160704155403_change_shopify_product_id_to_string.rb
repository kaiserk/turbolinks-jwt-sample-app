class ChangeShopifyProductIdToString < ActiveRecord::Migration[4.2][4.2]
  def change
    change_column :products, :shopify_product_id, :string
  end
end
