class AddSessionTokenToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :session_token, :string
  end

  def down
    remove_column :users, :session_token
  end
end
