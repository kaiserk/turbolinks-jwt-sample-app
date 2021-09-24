module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: true
    # field :shopify_id, String, null: true
    # field :units, Float, null: true
    # field :product_price, Float, null: true
    # field :unit_price, Float, null: true
    # field :shop_id, Integer, null: true
    # field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    # field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    # field :image_url, String, null: true
    # field :shopify_metafield_id, String, null: true
    # field :unit_name, String, null: true
  end
end
