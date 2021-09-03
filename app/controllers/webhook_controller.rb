class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :verify_webhook, only: [:uninstall, :product_update]
  before_action :set_shop, only: [:uninstall]

  def uninstall
    puts "WebhookC uninstall"
    if @shop && @shop.charge_id?
      @shop.reset! # forces user to accept charge on re-install
    end

    head :ok
  end

  # update unit pricing for registered products and variants, on-demand
  def product_update
    puts "WebhookC product_update"
    Product.delay.webhook(params)
    head :ok
  end

  def customers_redact
    head :ok
  end

  def customers_data_request
    head :ok
  end

  def shop_redact
    if params['shop_domain'] && Shop.find_by(shopify_domain: params['shop_domain'])
      shop = Shop.find_by(shopify_domain: params['shop_domain'])
      puts ""
      product_ids = Product.where(shop_id: shop.id).ids
      variant_ids = Variant.where(product_id: product_ids).ids
      Variant.where(id: variant_ids).destroy_all
      puts "variants destroyed"
      Product.where(id: product_ids).destroy_all
      puts "products destroyed"
      Preference.where(shop_id: shop.id).destroy_all
      puts "products destroyed"
      shop.destroy
      puts "shop destroyed"
    end
    puts ""
    head :ok
  end

  private

    def set_shop
      @shop = Shop.find_by(shopify_domain: params['myshopify_domain'])
    end

    def verify_webhook
      data = request.body.read.to_s
      hmac_header = request.headers['HTTP_X_SHOPIFY_HMAC_SHA256']
      digest  = OpenSSL::Digest.new('sha256')
      puts "WebhookController verify_webhook"
      calculated_hmac = (Base64.encode64(OpenSSL::HMAC.digest(digest, ShopifyApp.configuration.secret, data)) || '').strip
      unless calculated_hmac == hmac_header
        head :unauthorized
      end
      request.body.rewind
    end

end
