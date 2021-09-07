# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include ShopifyApp::EnsureAuthenticatedLinks
  include ShopifyApp::Authenticated

  def index
    @shop_origin = current_shopify_domain
  end

  def set_shop
    puts "AuthenticatedC set_shop start"
    # puts session.to_json
    # shop = ShopifyAPI::Shop.current
    # @shop = Shop.find_by(domain: shop.myshopify_domain)
    # @shop = Shop.find_by(shopify_domain: current_shopify_domain)
    # puts @shop_origin
    @shop_origin = current_shopify_domain
    @shop = Shop.find_by(shopify_domain: @shop_origin)
    puts @shop.to_json
    puts "AuthenticatedC set_shop end"
  end

  def check_billing
    puts "AuthenticatedC check_billing start"
    # if @shop has charge_id then do nothing, if it doesn't have the redirect
    redirect_to charge_path unless @shop.charge_id?
    puts "AuthenticatedC check_billing end"
  end

  # def shop_session
  #   # return unless session[:shopify]
  #   # if @shop_session is nil then @shop_session = ShopifyApp::SessionRepository.retrieve(session[:shopify])
  #   # else it remains unchanged
  #   # puts @shop_session.to_json
  #   @shop_session = @shop_session || ShopifyApp::SessionRepository.retrieve_shop_session(session[:shopify])
  # end
end
