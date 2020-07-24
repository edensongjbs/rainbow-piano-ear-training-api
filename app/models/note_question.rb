class NoteQuestion < ApplicationRecord
    belongs_to :note
    belongs_to :question
end
