class Mutations::UpdateCurrencyMutation < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :currency, String, required: false
  argument :label_text, String, required: false
  argument :collection_label_text, String, required: false

  field :errors, [String], null: false

  def resolve(id:, **attributes)
    Preference.find(id).tap do |preference|
      preference.update!(attributes)
    end
  end
end

# class Mutations::UpdateVariantMutation < Mutations::BaseMutation
#   null true
#
#   argument :title, String, required: true
#   argument :id, ID, required: true
#
#   field :product, Types::ProductType, null: true
#   field :title, Types::ProductType, null: true
#   field :errors, [String], null: false
#
#   def resolve(id:, title:, **args)
#     # post = Post.find(post_id)
#     product = Variant.find(id)
#     # comment = post.comments.build(body: body, author: context[:current_user])
#     # title = product.titles.build(body: body, author: context[:current_user])
#     if product.update(args)
#       # Successful creation, return the created object with no errors
#       {
#         title: title,
#         errors: [],
#       }
#     else
#       # Failed save, return the errors to the client
#       {
#         title: nil,
#         errors: title.errors.full_messages
#       }
#     end
#     rescue ActiveRecord::RecordNotFound
#       return { success: false, product: nil, errors: ['record-not-found'] }
#   end
# end
