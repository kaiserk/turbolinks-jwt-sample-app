class ChangeDomainToShopifyDomainFromShops < ActiveRecord::Migration[6.0]
  def change
    rename_column :shops, :domain, :shopify_domain
  end
end
