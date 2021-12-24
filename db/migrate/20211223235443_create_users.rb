class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.string :password_digest
      t.boolean :active
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :users, :email, unique: true, where: 'deleted_at IS NULL'
  end
end
