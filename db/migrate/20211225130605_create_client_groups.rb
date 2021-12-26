class CreateClientGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :client_groups do |t|
      t.string :description, null: false
      t.timestamp :deleted_at

      t.timestamps
    end

    add_index :client_groups, :description, unique: true, where: 'deleted_at IS NULL'
  end
end
