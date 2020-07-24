class Note < ApplicationRecord
    has_many :chord_notes
    has_many :chords, through: :chord_notes
    has_many :note_questions
    has_many :questions, through: :note_questions
end
