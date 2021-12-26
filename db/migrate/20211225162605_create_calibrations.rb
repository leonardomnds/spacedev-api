class CreateCalibrations < ActiveRecord::Migration[6.1]
  def change
    create_table :calibrations do |t|
      t.references :instrument, null: false, foreign_key: true
      t.date :date, null: false
      t.string :laboratory
      t.string :certificate_number
      t.timestamp :deleted_at

      t.timestamps
    end

    add_index :calibrations, :date
  end
end
