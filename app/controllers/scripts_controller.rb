class ScriptsController < ApplicationController
  include ShopifyApp::Authenticated

  protect_from_forgery except: :widget
  before_action :set_shop, only: [:widget]

  def home
  end

  def widget

    respond_to do |format|
      format.js
      format.css
    end

  end

  private

    # def set_shop
    #   puts '*** Setting the shop ***'
    #   # example, prior to parsing: "QUERY_STRING"=>"shop=bone-broth-co.myshopify.com"
    #   shop = request.env['QUERY_STRING'].split("=")[1]
    #   puts 'Shop origin: '
    #   @shop_origin = current_shopify_domain
    #   puts @shop_origin
    #   # @shop = Shop.find_by(shopify_domain: shop)
    #   @shop = Shop.find_by(shopify_domain: @shop_origin)
    # end

    def set_shop
      puts "AuthenticatedC set_shop start"
      # puts session.to_json
      # shop = ShopifyAPI::Shop.current
      # @shop = Shop.find_by(domain: shop.myshopify_domain)
      # @shop = Shop.find_by(shopify_domain: current_shopify_domain)
      # puts @shop_origin
      @shop_origin = current_shopify_domain
      @shop = Shop.find_by(shopify_domain: @shop_origin)
      puts "******************************"
      puts @shop.to_json
      puts @shop.preference.currency
      puts "AuthenticatedC set_shop end"
    end

end
