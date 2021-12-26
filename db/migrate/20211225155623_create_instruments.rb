class CreateInstruments < ActiveRecord::Migration[6.1]
  def change
    create_table :instruments do |t|
      t.references :client, null: false, foreign_key: true
      t.string :tag, null: false
      t.string :description, null: false
      t.integer :calibration_time, null: false, default: 0
      t.string :responsible
      t.string :area
      t.string :subarea
      t.string :manufacturer
      t.string :serial_number
      t.string :range
      t.string :resolution
      t.boolean :active, null: false, default: true
      t.timestamp :deleted_at

      t.timestamps
    end

    add_index :instruments, :tag
    add_index :instruments, :description
  end
end
