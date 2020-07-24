class Level < ApplicationRecord
    belongs_to :game
    has_many :user_levels
    has_many :users, through: :user_levels
    # has_many :level_questions
    has_many :questions #, through: :level_questions
end
