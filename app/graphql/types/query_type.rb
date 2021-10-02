module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    #PRODUCTS
    field :products, [Types::ProductType], null: true do
      argument :shop_id, Integer, required: true
    end

    def products(shop_id:)
      Product.where(shop_id: shop_id)
    end

    # field :product_name, [Types::String], null: true do
    #   argument :product_id, Integer, required: true
    # end
    #
    # def product_name(product_id:)
    #   Product.where(product_id: product_id).title
    # end

    # field :products_variants, [Types::ProductType], null: true do
    #   argument :shop_id, Integer, required: true
    # end

    # def products_variants(shop_id:)
    #   Variant.find_by_sql('select products.title, variants.title, variants.variant_price, variants.units, variants.unit_price from variants, products where variants.product_id=products.id AND products.shop_id=' + shop_id)
    # end

    #VARIANTS
    # field :variants, [Types::VariantType], null: true
    #
    # def variants()
    #   Variant.all
    # end
  end
end
