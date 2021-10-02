# class ProductsController < AuthenticatedController
#   def index
#     @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
#     render(json: { products: @products })
#   end
# end

class ProductsController < AuthenticatedController
  include SearchesHelper
  before_action :set_shop
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @shop_origin = current_shopify_domain
    @products = @shop.products.paginate(:page => params[:page], :per_page => 30)
    # @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    # @products = shopify_products.paginate(:page => params[:page], :per_page => 30)

    @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })
    # products_render = json: { products: @products }
    puts '*** products_render ***'
    puts @products
    render(json: { products: @products })
  end

  def create
    puts "**** about to save ****"

    @product = @shop.products.new(product_params.except(:variants_attributes))
    if product_params[:variants_attributes]
      product_params[:variants_attributes].each {|v| @product.variants.new(v[1])}
    end

    respond_to do |format|
      if @product.save
        if @product.units?
          format.html {redirect_to products_path, :notice => 'Product saved successfully.'}
        else
          # redirects to management page in the case there are variants
          format.html {redirect_to product_path(@product)}
        end
      else
        format.html {redirect_to dashboard_path, :notice => 'Sorry, an error occured.'}
      end
    end
  end

  def show
    puts 'aShowing products...'
    if !@product
      product_object = ShopifyAPI::Product.find(params[:id])

      if !product_object
        flash[:notice] = 'Product not found'
        redirect_to products_path
      end

      if product_object.class == Product
        image_url = product_object.image_url
      else # direct from shopify, different data structure
        image_url = product_object.image.try(:src)
      end

      product = Product.create(
        :title => product_object.title,
        :shopify_id => product_object.id,
        :shop_id => @shop.id,
        :image_url => image_url,
        )

      if product_object.variants
        product_object.variants.each do |v|
          Variant.create(
            :title => v.title,
            :shopify_id => v.id,
            :product_id => product.id,
            :units => 1,
            :variant_price => v.price,
            )
        end
      end

      @product = Product.find_by_id(product.id)
    end
  end

  def update
    respond_to do |format|
      # if @product.update_attributes(product_params)
      if @product.update_attributes(product_params)
        flash[:notice] = 'Product units updated successfully.'
        format.json { respond_with_bip(@product) }
        format.html {redirect_to dashboard_path}
      else
        format.html {render :index }
        format.json { respond_with_bip(@user) }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @product && @product.destroy!
        format.html {redirect_to products_path, :notice => 'Product successfully removed.'}
      else
        format.html {redirect_to products_path, :notice => 'Sorry, something went wrong.'}
      end
    end
  end

  def bulk
    #{"title"=>"Pair of dumbbells - red, 2.5 kg", "shopify_id"=>"1717981413476", "units"=>"2", "product_price"=>"50.00", "image_url"=>"https://cdn.shopify.com/s/files/1/0071/8340/1060/products/2.5kg_pairs.jpg?v=1545122264"}

    if params.has_key?(:bulk_items)

      #puts params['bulk_item'].to_yaml
      params['bulk_items'].each do |key, value|
        product = ShopifyAPI::Product.find(key)

        if elligible_variants?(product)
        else
          product_params = {
            "title" => product.title,
            "shopify_id" => key,
            "image_url" => product.image.try(:src),
            "units" => value,
            "product_price" => product.try(:price) || product.variants.try(:first).try(:price)
          }
          new_product = @shop.products.new(product_params)
          new_product.save
        end
      end
    end

    redirect_to products_path
  end

  private

  def set_product
    @product = Product.find_by_id(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :shopify_id, :units, :product_price, :unit_price, :image_url, :shop_id, variants_attributes: [:id, :shopify_id, :title, :variant_price, :_destroy])
  end

end
