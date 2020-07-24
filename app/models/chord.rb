class Chord < ApplicationRecord
    has_many :chord_levels
    has_many :chord_notes
    has_many :notes, through: :chord_notes
end
