class User < ApplicationRecord
    has_many :user_levels
    has_many :levels, through: :user_levels
    has_secure_password
    after_commit :generate_all_user_levels, on: :create
    validates :email, presence: true
    validates :email, uniqueness: true
    validates :first_name, presence: true

    def next_level(game)
        game_levels = self.user_levels.to_a.select{|ul| ul.level.game==game && ul.completed}
        if highest_completed
            highest_completed = completed_levels.max_by{|l| l.level.level_num && l.completed}.level

        else
            return self.user_levels.to_a.find{|ul| ul.level.level_num==1 && ul.level.game==game}.level
        end
    end

    def current_highest_level(game)
        completed_levels = self.user_levels.to_a.select{ |ul| ul.level.game_id == game.id && ul.completed }
        if completed_levels.length > 0
            return completed_levels.max_by{|ul| ul.level.level_num}
        else
            return self.user_levels.to_a.find{|ul| ul.level.game==game && ul.level.level_num == 1}
        end
    end

    def lowest_uncompleted_level(game)
        uncompleted_levels = self.user_levels.to_a.select{ |ul| ul.level.game_id == game.id && !ul.completed }
        if uncompleted_levels.length > 0
            return uncompleted_levels.min_by{|ul| ul.level.level_num}
        else
            return self.user_levels.to_a.find{|ul| ul.level.game==game && ul.level.level_num == 1}
        end
    end

    def serve_level(level)
        req_lev = self.user_levels.to_a.find{|ul| ul.user_id == self.id && ul.level_id ==level.id}
        if req_lev
            if req_lev.completed
                return req_lev
            else
                return lowest_uncompleted_level(level.game)
            end
        else
            return UserLevel.create(level_id: level.id, user_id: self.id)
        end
    end

    def high_score_array(game)
        self.user_levels.to_a.select{|ul| ul.level.game.id == game.id }.sort_by{|ul| ul.level.level_num}.map{|ul|ul.best_score}
    end

    def user_object
        return {
            email: self.email,
            first_name: self.first_name,
            game_1: {
                highest_completed_level: ( self.current_highest_level(Game.all[0]).completed ? self.current_highest_level(Game.all[0]).level.level_num : 0),
                high_scores: high_score_array(Game.all[0])
            },
            game_2: {
                highest_completed_level: ( self.current_highest_level(Game.all[1]).completed ? self.current_highest_level(Game.all[1]).level.level_num : 0),
                high_scores: high_score_array(Game.all[1])
            },
            game_3: {
                highest_completed_level: ( self.current_highest_level(Game.all[2]).completed ? self.current_highest_level(Game.all[2]).level.level_num : 0),
                high_scores: high_score_array(Game.all[2])
            },
            game_4: {
                highest_completed_level: ( self.current_highest_level(Game.all[3]).completed ? self.current_highest_level(Game.all[3]).level.level_num : 0),
                high_scores: high_score_array(Game.all[3])
            }
        }
    end

    private
    
    def generate_all_user_levels
        Level.all.each{ |l| self.levels << l}
        # byebug
        # Game.all.each { |g| g.levels.to_a.each { |l| UserLevel.create(level_id: l, user_id: self.id)}}
    end


end
