class CreateNoteQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :note_questions do |t|
      t.integer :note_id
      t.integer :question_id
      t.integer :position

      t.timestamps
    end
  end
end
