class DestroyMetafieldsJob
  include SuckerPunch::Job

  def perform(shop)
    ActiveRecord::Base.connection_pool.with_connection do
      shop.products.each {|project| MetafieldService.destroy(project)}
      shop.variants.each {|variant| MetafieldService.destroy(variant)}
      puts "#{shop.shopify_domain} metafields destroyed."
    end
  end
end
