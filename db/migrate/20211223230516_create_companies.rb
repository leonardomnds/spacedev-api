class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :trading_name
      t.string :cpf_cnpj
      t.string :tenant_name
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :companies, :tenant_name, unique: true
  end
end
