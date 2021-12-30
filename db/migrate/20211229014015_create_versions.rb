class CreateVersions < ActiveRecord::Migration[6.1]
  def change
    create_table :versions do |t|
      t.string   :item_type,      null: false
      t.bigint   :item_id,        null: false
      t.string   :event,          null: false
      t.string   :remote_ip
      t.bigint   :whodunnit
      t.json     :object
      t.json     :object_changes
      t.string   :request_uuid
      t.datetime :created_at
    end
    add_index :versions, %i(item_type item_id)
  end
end
