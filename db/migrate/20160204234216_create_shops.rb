class CreateShops < ActiveRecord::Migration[6.0]
  def self.up
    create_table :shops  do |t|
      t.string :domain, null: false
      t.string :token, null: false
      t.timestamps
    end

    add_index :shops, :shopify_domain, unique: true
  end

  def self.down
    drop_table :shops
  end
end
