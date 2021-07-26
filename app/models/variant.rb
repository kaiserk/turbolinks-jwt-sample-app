class Variant < ActiveRecord::Base
  include Metafields

  belongs_to :product
  before_create :guess_units
  before_create :calculate_unit_price
  before_update :calculate_unit_price

  after_save :create_or_update_metafield, if: Proc.new{ |variant| !variant.skip_callback }
  after_create :create_or_update_metafield
  #before_destroy :destroy_metafield

  def skip_callback(value = false)
    @skip_callback = @skip_callback ? @skip_callback : value
  end

  # regex removes "str / XXX / str" variant data
  def guess_units
    if self.title.to_f > 0
      self.units = self.title.to_f
    else
      self.units = self.title.scan(/\d+/).first.try(:to_f)
    end
    self.units = 1
  end

  def calculate_unit_price
    puts "calculate_unit_price"
    return unless self.units? && self.variant_price?
    self.unit_price = (self.variant_price / self.units).round(2)
  end

  def shop
    self.product.shop
  end

end
