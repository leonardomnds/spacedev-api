class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company_name, null: false
      t.string :trading_name
      t.string :cpf_cnpj, null: false
      t.string :tenant_name, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :companies, :tenant_name, unique: true
  end
end
