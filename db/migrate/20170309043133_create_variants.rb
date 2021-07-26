class CreateVariants < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :variants do |t|
      t.text :title
      t.string :shopify_variant_id
      t.float :units
      t.float :variant_price
      t.float :unit_price
      t.references :product, index: true, foreign_key: true
      t.string :shopify_metafield_id
      t.timestamps null: false
    end
  end
end
