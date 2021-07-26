class CreateWebhookEvents < ActiveRecord::Migration[4.2][4.2]
  def change
    create_table :webhook_events do |t|
      t.references :shop, index: true, foreign_key: true
      t.string   "event_type"
      t.text     "description",    :limit => 255
      t.boolean  "logical_delete"
      t.timestamps null: false
    end
  end
end
