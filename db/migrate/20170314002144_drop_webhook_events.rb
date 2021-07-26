class DropWebhookEvents < ActiveRecord::Migration[4.2][4.2]
  def change
    drop_table :webhook_events
  end
end
