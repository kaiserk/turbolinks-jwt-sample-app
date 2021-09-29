module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # field :products, [Types::ProductType], null: true,
    #       description: "An example field added by the generator"

    field :products, [Types::ProductType], null: true do
      argument :shop_id, Integer, required: true
    end

    def products(shop_id:)
      # Product.find_each
      Product.where(shop_id: shop_id)
    end
  end
end
