module Metafields

  def create_or_update_metafield
    MetafieldService.create_or_update(self)
  end

  def destroy_metafield
    if self.class == Variant
      MetafieldService.destroy(self.product) unless self.shop.charge_id.nil?
    else
      MetafieldService.destroy(self) unless self.shop.charge_id.nil?
    end
  end

end
