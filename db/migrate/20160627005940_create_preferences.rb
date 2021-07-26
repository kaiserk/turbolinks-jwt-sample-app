class CreatePreferences < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :preferences do |t|
      t.string :currency
      t.references :shop, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
