module SearchesHelper

  def elligible_variants?(product)
    status = false
    variants = product.variants

    return true if (variants && product.class == Product)

    variants.each do |variant|
      options = variant.option1, variant.option2, variant.option3
      options.compact!

      options.each do |option|
        # if option.to_i.to_s == option only checks for quantity / num field
        if (option.to_s.scan(/\d+/).first.try(:to_f) || 0) > 0
          status = true
        end
      end
    end

    status
  end

end
