# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorageWithScopes

  def uninstall
    destroy
  end

  def uninstall!
    destroy!
  end

  def api_version
    ShopifyApp.configuration.api_version
  end

  has_many :products, :dependent => :destroy
  has_many :variants, through: :products
  has_one :preference, :dependent => :destroy

  # after_create :update_slack
  after_create :set_default_currency

  # def self.store(session)
  #   shop = self.find_or_create_by(shopify_domain: session.url)
  #   shop.token = session.token
  #   shop.save!
  #   shop.id
  # end

  def self.retrieve(id)
    if shop = self.where(id: id).first
      ShopifyAPI::Session.new(shop.shopify_domain, shop.shopify_token)
    end
  end

  # def update_slack
  #   SlackBot.ping "new Unit Pricer install (not activated): #{self.shopify_domain}"
  # end

  def set_default_currency
    puts self.to_json
    puts "Shop created => initiating Preference Create"
    Preference.create(currency: '$', shop_id: self.id)
  end

  def reset!
    self.update(charge_id: nil, token: nil)

    # can't remotely destroy when token non-existence
    # DestroyMetafieldsJob.perform_async(self)
    DestroySnippetJob.perform_async(self)
    SlackBot.ping "Unit Pricer charge cancelled: #{self.shopify_domain}"
  end

  def credit_account(amount)
    params = {
      application_credit: {
        description: "Unit Pricer Credit", # => appears on User's Shopify bill
        amount: amount # => ie: 10 (for $10)
      }
    }

    resp = Curl.post("https://#{self.shopify_domain}/admin/application_credits.json?access_token=#{self.token}", params.to_json)
    resp.status.include?('20')
  end

  # batch operation - white glove onboarding
  def import_shopify_products
    shopify_products = all_shopify_products
    return unless shopify_products

    shopify_products.each do |shopify_product|
      shopify_variants = shopify_product.variants
      product = self.products.create(title: shopify_product.title, shopify_id: shopify_product.id, units: nil, product_price: nil, unit_price: nil, image_url: shopify_product.image.src)

      shopify_variants.each do |shopify_variant|
        product.variants.create(shopify_id: shopify_variant.id, title: shopify_variant.title, variant_price: shopify_variant.price)
      end
    end
  end

  def sessionize
    session = ShopifyAPI::Session.new(self.shopify_domain, self.token)
    ShopifyAPI::Base.activate_session(session)
  end

  def all_shopify_products
    sessionize
    ShopifyAPI::Product.find(:all, :params => {:limit => 250})
  end
end
