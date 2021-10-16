module Types
  class PreferenceType < Types::BaseObject
    field :id, ID, null: false
    field :currency, String, null: true
    field :shop_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :label_text, String, null: true
    field :delimiter, String, null: true
    field :insert_order, String, null: true
    field :variant_label_text, String, null: true
    field :collection_label_text, String, null: true
  end
end
