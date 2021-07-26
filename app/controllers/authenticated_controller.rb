# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include ShopifyApp::EnsureAuthenticatedLinks
  include ShopifyApp::Authenticated

  # def shop_session
  #   # return unless session[:shopify]
  #   # if @shop_session is nil then @shop_session = ShopifyApp::SessionRepository.retrieve(session[:shopify])
  #   # else it remains unchanged
  #   # puts @shop_session.to_json
  #   @shop_session = @shop_session || ShopifyApp::SessionRepository.retrieve_shop_session(session[:shopify])
  # end
end
