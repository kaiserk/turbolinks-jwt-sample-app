module Types
  class MutationType < Types::BaseObject
    field :update_variant, mutation: Mutations::UpdateVariantMutation
  end
end
