class ShopsController < AuthenticatedController

  def update
    if @shop.update(shop_params)
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    @shop.destroy
    redirect_to root_path
  end

  private

    def shop_params
      params.require(:shop)
    end

end
