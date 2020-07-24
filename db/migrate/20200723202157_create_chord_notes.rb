class CreateChordNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :chord_notes do |t|
      t.integer :chord_id
      t.integer :note_id
      t.integer :position

      t.timestamps
    end
  end
end
