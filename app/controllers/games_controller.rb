class GamesController < ApplicationController
    def show
        game = Game.all[params[:id].to_i-1]
        lev = game.levels.find_by(level_num: (params[:level].to_i))
        user = @logged_in_user
        user_level = user.serve_level(lev)
        # high_level = user.highest_completed_level(game)
        # if !level 
        #     level = game.levels.last
        #
        # byebug
        qs = ( game==Game.all[1] || game==Game.all[2] || user_level.level.level_num == 1) ? select_questions(game, user_level.level, 6, 0) : select_questions(game, user_level.level)
        # byebug
        render json: custom_serialize(qs, game, user_level.level, user_level.id)
    end

    private

    def select_questions(game, level, num_new=4, num_old=2)
        # byebug
        old_levels = game.levels.select{|l| l.level_num<level.level_num}
        questions = []
        (num_new).times {questions << level.questions.sample}
        if num_old > 0
            (num_old).times do
                l = old_levels.sample
                # byebug
                questions << l.questions.sample
            end
        # else
            # (num_old).times {questions << level.questions.sample}
        end
        # byebug
        return questions.shuffle
    end

    def custom_serialize(qs, game, level, user_level_id)
        full_obj = {
            user_level_id: user_level_id,
            questions:[], 
            game_message: game.intro_message,
            order_matters: game.order_matters, 
            game_intro_sound: game.intro_sound_url,
            play_first: game.play_first,
            chords_allowed: game.chords_allowed,
            list_note_names: game.list_note_names,
            level_num: level.level_num,
            arpeggiated: level.arpeggiated,
            level_message: level.level_message,
            level_message_sound: level.level_message_sound_url
        }
        qs.each do |q|
            q_obj = {
                text: q.question_text,
                sound_url: q.sound_url,
                use_solfege: q.use_solfege,
                play_first: q.level.game.play_first,
                order_matters: q.level.game.order_matters,
                chords_allowed: q.level.game.chords_allowed,
                arpeggiated: q.level.arpeggiated,
                demo_notes: q.level.demo_notes.split(':'),
                either_c: q.level.game.either_c,
                notes: []
            }
            q.notes_in_order.each do |n|
                q_obj[:notes] << {note_value: n.note_value, solfege_value: n.solfege_value, pitch_name: n.pitch_name, note_name_sound_url: n.note_name_sound_url, solfege_sound_url: n.solfege_sound_url}
            end
            full_obj[:questions] << q_obj
        end

        full_obj
    end
end