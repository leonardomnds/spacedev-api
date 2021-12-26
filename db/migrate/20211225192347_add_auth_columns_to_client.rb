class AddAuthColumnsToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :password_digest, :string
    add_column :clients, :session_token, :string
  end
end
