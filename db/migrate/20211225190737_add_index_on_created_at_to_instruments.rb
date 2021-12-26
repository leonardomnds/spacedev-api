class AddIndexOnCreatedAtToInstruments < ActiveRecord::Migration[6.1]
  def change
    add_index :instruments, :created_at
  end
end
