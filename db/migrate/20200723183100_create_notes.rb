class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.string :note_value
      t.string :solfege_value
      t.string :pitch_name
      t.string :note_name_sound_url, default: ""
      t.string :solfege_sound_url, default: ""

      t.timestamps
    end
  end
end
