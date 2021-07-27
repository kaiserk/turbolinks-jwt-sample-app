class UnitPricesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_shopify_product, only: [:show, :update]
  before_action :set_shopify_variant, only: [:show_variant]

  def show
    if @product.present?
      is_variant = false
      if @product.variants.count > 0
        is_variant = true
      end

      render json: {status: 'ok', unit_price: @product.unit_price, units: @product.units, is_variant: is_variant}
    else
      render :json => { :success => false }
    end
  end

  def show_variant
    if @variant.present?
      
      render json: {status: 'ok', unit_price: @variant.unit_price, units: @variant.units}
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

end
