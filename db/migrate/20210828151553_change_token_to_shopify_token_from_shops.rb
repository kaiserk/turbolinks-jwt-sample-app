class ChangeTokenToShopifyTokenFromShops < ActiveRecord::Migration[6.0]
  def change
    rename_column :shops, :token, :shopify_token
  end
end
