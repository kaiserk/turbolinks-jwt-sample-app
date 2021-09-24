module Types
  class MutationType < Types::BaseObject
    field :update_product, mutation: Mutations::UpdateProductMutation
    # field :update_product, mutation: Mutations::Products::UpdateProduct

    # field :update_product, String, null: false,
    #   description: "Update product title"
    # def updateTitle
    #   "Hello World"
    # end
  end
end
