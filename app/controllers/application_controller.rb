# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :set_shop

  # working version
  # def index
  #   @shop_origin = current_shopify_domain
  # end
  #
  # def set_shop
  #   puts "AuthenticatedC set_shop start"
  #   #puts session.to_json
  #   shop = ShopifyAPI::Shop.current
  #   @shop = Shop.find_by(domain: shop.myshopify_domain)
  #   # @shop = Shop.find_by(shopify_domain: @shop_origin)
  #   puts @shop.to_json
  #   puts "AuthenticatedC set_shop end"
  # end
  #
  # def check_billing
  #   puts "AuthenticatedC check_billing start"
  #   # if @shop has charge_id then do nothing, if it doesn't have the redirect
  #   redirect_to charge_path unless @shop.charge_id?
  #   puts "AuthenticatedC check_billing end"
  # end

end
