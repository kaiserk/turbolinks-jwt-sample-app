module ApplicationHelper

  def product_units(product)
    product = Product.find_by(shopify_id: product.id)
    product.units if !!product
  end

  def variant_units(variant)
    variant = Variant.find_by(shopify_id: variant.id)
    variant.units if !!variant
  end

  def variant_price(variant)
    variant.try(:price) || variant.try(:variant_price)
  end

  def product_price(product)
    product.try(:price) || product.variants.try(:first).try(:price)
  end

  def variant_id(variant)
    variant.try(:shopify_id) || variant.try(:id)
  end

  def product_image(product)
    img = if product.class == Product
            product.image_url
          else # direct from shopify, different data structure
            product.image.try(:src)
          end

    img || ''
  end

  def pricing_tooltip
    "How many individual products are included at this price? We'll do the math."
  end

end
