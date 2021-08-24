class Product < ApplicationRecord
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
    # puts params
    product = Product.find_by(shopify_id: params[:id])

    # puts product

    if product
      variants = params[:variants]

      variants.each do |shopify_variant|
        puts 'iterating variants'
        puts shopify_variant
        # local_variant = Variant.find_by(shopify_id: shopify_variant[:shopify_id])
        # puts local_variant
        puts 'shopify_variant[:product_id] = ' + shopify_variant[:product_id].to_s
        local_variant = Product.find_by(shopify_id: shopify_variant[:product_id])
        puts 'just after local variant is declared'
        puts local_variant
        next unless local_variant
        puts '\n'
        puts local_variant

        if local_variant && local_variant.units
          new_unit_price = (shopify_variant[:price].to_f / local_variant.units.to_f).round(2)
        end
        puts shopify_variant[:title]
        puts new_unit_price
        puts 'about to update local variant'
        puts local_variant.unit_price
        local_variant.update(title: shopify_variant[:title], product_price: shopify_variant[:price], unit_price: shopify_variant[:title])
     end
    end
  end

end
