class AddIndexOnCreatedAtToClients < ActiveRecord::Migration[6.1]
  def change
    add_index :clients, :created_at
  end
end
