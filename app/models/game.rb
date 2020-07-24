class Game < ApplicationRecord
    has_many :levels
    has_many :level_questions, through: :levels
    has_many :questions, through: :level_questions
    has_many :user_levels, through: :levels
    has_many :users, through: :user_levels
end
