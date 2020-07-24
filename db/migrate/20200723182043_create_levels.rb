class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels do |t|
      t.integer :level_num
      # t.integer :max_num_notes, default: 3
      # t.integer :num_questions, default: 5
      t.integer :game_id
      t.boolean :arpeggiated, default: true
      t.string :level_message
      t.string :level_message_sound_url, default: ""

      t.timestamps
    end
  end
end
