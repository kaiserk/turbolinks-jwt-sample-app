class ScriptsController < ApplicationController
  before_action :set_shop, only: [:widget]

  def home
  end

  def widget
    respond_to do |format|
      format.js
      format.css
    end
  end

  private

    def set_shop
      # example, prior to parsing: "QUERY_STRING"=>"shop=bone-broth-co.myshopify.com"
      shop = request.env['QUERY_STRING'].split("=")[1]
      @shop = Shop.find_by(domain: shop)
    end

end
