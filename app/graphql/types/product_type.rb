module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    field :shopify_id, String, null: true
    field :units, Float, null: true
    field :product_price, Float, null: true
    field :unit_price, Float, null: true
    field :shop_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :image_url, String, null: true
    field :shopify_metafield_id, String, null: true
    field :unit_name, String, null: true
    field :variants, [VariantType], null: true

    # do
    #   argument :product_id, Integer, required: false
    # end
    #
    # def variants(product_id: nil)
    #   variants = object.variants
    #   if !product_id.nil?
    #     variants = variants.where(product_id: product_id)
    #   end
    #   variants
    # end
  end
end
