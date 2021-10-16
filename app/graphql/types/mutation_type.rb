module Types
  class MutationType < Types::BaseObject
    field :update_variant, mutation: Mutations::UpdateVariantMutation
    field :update_currency, mutation: Mutations::UpdateCurrencyMutation
  end
end
