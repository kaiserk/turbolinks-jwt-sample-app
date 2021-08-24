ShopifyApp.configure do |config|
  config.scripttags = [
    {event:'onload', src: "#{ENV['APP_URL']}widget.js"}
  ]
end