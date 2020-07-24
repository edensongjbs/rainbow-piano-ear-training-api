class CreateChords < ActiveRecord::Migration[6.0]
  def change
    create_table :chords do |t|
      t.string :roman_numeral
      t.string :chord_name

      t.timestamps
    end
  end
end
