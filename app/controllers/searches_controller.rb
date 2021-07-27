class SearchesController < AuthenticatedController
  before_action :set_shop
  require 'uri'

  def show
    begin
      if is_number?(search_query) # find product by id
          @single_product = ShopifyAPI::Product.find(search_query)
       else # find product by title
          @results = ShopifyAPI::Product.find(:all, params: {title: URI.encode(search_query).gsub("%20", '%')})
       end
    rescue ActiveResource::ResourceNotFound # doesn't exist on shopify
      redirect_to dashboard_path, :notice => "Sorry, we couldn't find that product."
    end

    if @single_product
      existing_product = Product.find_by(shopify_id: @single_product.id)
      @results = existing_product ? [existing_product] : [@single_product]
    end

    if @results
      cached_results = @results

      @results = []
      cached_results.each do |result|
        existing_product = Product.find_by(shopify_id: result.id)
        @results << (existing_product || result)
      end
    end

    @product = Product.new
  end

  private

    def search_query
      params[:query]
    end

    def is_number? string
      true if Float(string) rescue false
    end
end
