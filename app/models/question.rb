class Question < ApplicationRecord
    has_many :note_questions
    has_many :notes, through: :note_questions
    # has_many :level_questions
    # has_many :levels, through: :level_questions
    belongs_to :level

    def assign_notes(note_ar)
        note_ar.each_with_index do |note, i|
            self.notes << note
            byebug
            NoteQuestion.find_by(question: self, note: note).update_attributes(position: i)
        end
    end
end
