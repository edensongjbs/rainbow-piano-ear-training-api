class CreateChordLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :chord_levels do |t|
      t.integer :chord_id
      t.integer :level_id

      t.timestamps
    end
  end
end
