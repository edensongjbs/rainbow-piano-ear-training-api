class ChordNote < ApplicationRecord
    belongs_to :chord
    belongs_to :note
end
