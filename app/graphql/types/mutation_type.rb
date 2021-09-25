module Types
  class MutationType < Types::BaseObject
    field :update_product, mutation: Mutations::UpdateProductMutation
  end
end
