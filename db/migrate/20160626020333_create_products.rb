class CreateProducts < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :products do |t|
      t.text :title
      t.integer :shopify_product_id
      t.float :units
      t.float :product_price
      t.float :unit_price
      t.references :shop, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
