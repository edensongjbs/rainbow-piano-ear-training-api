class Question < ApplicationRecord
    has_many :note_questions
    has_many :notes, through: :note_questions
    # has_many :level_questions
    # has_many :levels, through: :level_questions
    belongs_to :level

    def assign_notes(note_ar)
        note_ar.each_with_index do |note, i|
            nq = NoteQuestion.create(note: note, question: self, position: i+1)
            self.note_questions << nq
        end
    end

        # note_ar.each_with_index do |note|
        #     self.notes << note
        # end
        # all_note_questions = self.note_questions
        # note_ar.each_with_index do |note, i|
        #     nq = all_note_questions.find(|e| e.question==self, e.note==note)
        #     nq.update_attributes(position: 1)
        #     all_note_questions.reject!(nq)
        #     # NoteQuestion.find_by(question: self, note: note).update_attributes(position: i)
        # end
    # end

    def notes_in_order
        self.note_questions.sort_by{|nq| nq.position}.map{|nq| nq.note }
        
        # self.notes.sort_by{ |n| NoteQuestion.find_by(question: self, note: n).position }
    end
end
