# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  before_action :login_again_if_different_shop
  around_filter :shopify_session
  layout 'embedded_app'
  # include ShopifyApp::EnsureAuthenticatedLinks
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

  protected

  def login_again_if_different_shop
    puts "AuthenticatedC login_again_if_different_shop start"
    #puts "session:" + session.to_json
    if shop_session && params[:shop] && params[:shop].is_a?(String) && shop_session.url != params[:shop]
      session[:shopify] = nil
      session[:shopify_domain] = nil
      #redirect_to_login
      # In some cases redirect_to_login goes to /login without the shop parameter that's why I changed it
      fullpage_redirect_to "#{main_app.root_url}/login?shop=#{params[:shop]}"
    end
    puts "AuthenticatedC login_again_if_different_shop end"
  end

  def shopify_session
    if shop_session && shop_session.url && shop_session.token
      puts "AuthenticatedC shopify_session is_shop_session"
      begin
        ShopifyAPI::Base.activate_session(shop_session)
        yield
      ensure
        ShopifyAPI::Base.clear_session
      end
    else
      puts "AuthenticatedC shopify_session is_not_shop_session"
      #redirect_to_login
      # In some cases redirect_to_login goes to /login without the shop parameter that's why I changed it
      if params[:shop] && params[:shop].is_a?(String)
        fullpage_redirect_to "#{main_app.root_url}/login?shop=#{params[:shop]}"
      else
        redirect_url = "#{main_app.root_url}/login"
        redirect_url ["//login"]  = "/login"
        redirect_to redirect_url
      end
    end
  end

end
