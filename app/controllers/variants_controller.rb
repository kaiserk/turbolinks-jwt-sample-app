class VariantsController < AuthenticatedController
  before_action :set_shop
  before_action :set_variant, only: [:update, :destroy]

  def update
    puts "VariantsC update"
    respond_to do |format|
      if @variant.update(variant_params)
        flash[:notice] = 'Variant units updated successfully.'
        format.json { respond_with_bip(@variant) }
        format.html {redirect_to dashboard_path}
      else
        format.html {render :index }
        format.json { respond_with_bip(@user) }
      end
    end
  end

  def destroy
    puts "VariantsC destroy"
    respond_to do |format|
      if @variant.destroy!
          format.html {redirect_to variants_path, :notice => 'Variant unit pricer successfully removed.'}
      else
        format.html {redirect_to variants_path, :notice => 'Sorry, something went wrong.'}
      end
    end
  end

  private

  def set_variant
    @variant = Variant.find(params[:id])
  end

  def variant_params
    params.require(:variant).permit(:title, :shopify_id, :units, :variant_price, :unit_price, :image_url, :shop_id, variants_attributes: [:id, :shopify_id, :title, :variant_price, :_destroy])
  end

end
