class CreateScriptTagsJob
  include SuckerPunch::Job

  def perform(session)
    ShopifyAPI::Base.activate_session(session) # required for doing authenticated things within background jobs
    scripts = ShopifyAPI::ScriptTag.all
    return unless scripts.count == 0

    script = ShopifyAPI::ScriptTag.new({event: "onload", src: ENV['HOST'] + '/widget.js'})
    script.save

    puts "Script tag planted."
  end
end
