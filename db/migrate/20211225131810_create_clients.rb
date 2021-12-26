class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :cpf_cnpj, null: false
      t.string :company_name, null: false
      t.string :trading_name
      t.string :document_number
      t.string :email
      t.string :phone
      t.string :cel_phone
      t.boolean :active, null: false, default: true
      t.references :client_group, null: true, foreign_key: true
      t.timestamp :deleted_at

      t.timestamps
    end

    add_index :clients, :cpf_cnpj, unique: true, where: 'deleted_at IS NULL'
  end
end
