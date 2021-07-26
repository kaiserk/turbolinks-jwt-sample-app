class Product < ActiveRecord::Base
  include Metafields
  belongs_to :shop
  has_many :variants, dependent: :destroy, inverse_of: :product

  before_save :calculate_unit_price

  after_save :create_or_update_metafield, if: Proc.new{ |product| !product.skip_callback }
  after_create :create_or_update_metafield
  #before_destroy :destroy_metafield

  def skip_callback(value = false)
    @skip_callback = @skip_callback ? @skip_callback : value
  end

  def calculate_unit_price
    self.unit_price = 0
    return unless self.variants.count.zero?

    return unless self.units?
    self.unit_price = (self.product_price / self.units).round(2)
  end

  def self.webhook(params)
    product = Product.find_by(shopify_id: params[:id])

    if product
      variants = params[:variants]

      variants.each do |shopify_variant|
        local_variant = Variant.find_by(shopify_id: shopify_variant[:id])
        next unless local_variant

        if local_variant && local_variant.units
          new_unit_price = (shopify_variant[:price].to_f / local_variant.units.to_f).round(2)
        end

        local_variant.update(title: shopify_variant[:title], unit_price: new_unit_price)
     end
    end
  end

end
