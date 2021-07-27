class DestroySnippetJob
  include SuckerPunch::Job

  def perform(shop)
    ActiveRecord::Base.connection_pool.with_connection do
      SnippetService.destroy(shop)
      puts "#{shop.domain} snippet destroyed."
    end
  end
end
