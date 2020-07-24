class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :level_id
      t.string :question_text
      t.string :sound_url, default: ""
      t.boolean :use_solfege, default: true

      t.timestamps
    end
  end
end
