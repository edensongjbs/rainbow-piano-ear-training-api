class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.boolean :order_matters, default: false
      t.string :intro_message, default: ""
      t.string :intro_sound_url, default: ""
      t.boolean :play_first, default: false
      t.boolean :chords_allowed, default: false
      t.boolean :list_note_names, default: false

      t.timestamps
    end
  end
end
