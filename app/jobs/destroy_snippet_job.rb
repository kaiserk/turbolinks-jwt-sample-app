class DestroySnippetJob
  include SuckerPunch::Job

  def perform(shop)
    ActiveRecord::Base.connection_pool.with_connection do
      SnippetService.destroy(shop)
      puts "#{shop.shopify_domain} snippet destroyed."
    end
  end
end
