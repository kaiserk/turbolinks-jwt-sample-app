class DashboardController < AuthenticatedController
  include SearchesHelper
  
  before_action :set_shop
  # before_action :check_billing # may need it back @kaiserk

  def index
  	puts "DashboardController index start"
    @shop_origin = current_shopify_domain

    # Get all Products with unit set

    # current_products = Product.all()
    # current_products = ShopifyAPI::Product.find(:all)
    current_products = Product.all()
    currend_prod_ids = []
    @shopify_products = []
    #Generate array with products' shopify_id
    current_products.each do |current|
      currend_prod_ids.push(current.shopify_id)
      # currend_prod_ids.push(current.id)
    end
    #get all products from shopify
    temp_shopify_products = ShopifyAPI::Product.find(:all)
    # get the first 10 Products without unit set
    temp_shopify_products.each do |current|
      @shopify_products.push(current) if !currend_prod_ids.include?(current.id.to_s)
      break if @shopify_products.count == 20
    end
    @product = Product.new
  end

  def show_collection
  end

  def manual_uninstall
  end

end
