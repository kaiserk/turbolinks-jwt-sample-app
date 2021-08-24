class UnitPricesController < ApplicationController
  # include ShopifyApp::Authenticated
  # skip_before_action :verify_authenticity_token
  # before_action :set_shop, only: [:show, :show_variant, :update]
  before_action :set_shopify_product
  before_action :set_shopify_variant
  before_action :get_shop

  def show
    if @product.present?
      is_variant = false
      if @product.variants.count > 1
        is_variant = true
      end

      # this will hide unit price if product price is the same
      if @product.variants.first.variant_price == @product.variants.first.unit_price
        unit_price = 0
      else
        unit_price = @product.variants.first.unit_price
      end

      puts 'unit price: '
      puts unit_price
      puts @product.product_price

      render json: {status: 'ok', unit_price: unit_price, units: @product.units, is_variant: is_variant, collection_label_text: @shop.preference.collection_label_text, label_text: @shop.preference.label_text, delimiter: @shop.preference.delimiter, currency: @shop.preference.currency, variant_label_text: @shop.preference.variant_label_text }
      # render json: {status: 'ok', unit_price: @product.unit_price, units: @product.units, is_variant: is_variant, collection_label_text: @shop.preference.collection_label_text }
    else
      render :json => { :success => false }
    end
  end

  def show_variant

    # this will hide unit price if variant price is the same
    if @variant.variant_price == @variant.unit_price
      unit_price = 0
    else
      unit_price = @variant.unit_price
    end

    puts 'unit price: '
    puts unit_price

    if @variant.present?
      render json: {status: 'ok', unit_price: unit_price, units: @variant.units, is_variant: true, collection_label_text: @shop.preference.collection_label_text, label_text: @shop.preference.label_text, delimiter: @shop.preference.delimiter, currency: @shop.preference.currency, insert_order: @shop.preference.insert_order, variant_label_text: @shop.preference.variant_label_text }
    else
      render :json => { :success => false }
    end
  end

  def update
    product_price = params[:product_price].to_f

    if @product.present?
      @product.product_price = product_price
      @product.save
      render json: {status: 'ok'}
    else
      render :json => { :success => false }
    end
  end

  private

    def set_shopify_product
      shopify_id = params[:shopify_id]
      @product = Product.find_by(shopify_id: shopify_id)
    end

    def set_shopify_variant
      shopify_id = params[:shopify_id]
      @variant = Variant.find_by(shopify_id: shopify_id)
    end

    def get_shop

      # shop_url = params[:shop_url]
      shop_url = params[:shop_url]
      puts params

      puts '** Shop url **'
      puts shop_url;

      @shop = Shop.find_by(shopify_domain: shop_url)
    end

end
