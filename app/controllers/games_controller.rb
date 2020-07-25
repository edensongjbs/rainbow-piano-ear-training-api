class GamesController < ApplicationController
    def show
        game = Game.all[params[:game].to_i-1]
        level = game.levels.find_by(level_num: (params[:level].to_i))
        if !level 
            level = Game.levels.last
        end
        qs = select_questions(game, level)
        render json: custom_serialize(qs, game, level)
    end

    private

    def select_questions(game, level, num_new=4, num_old=2)
        old_levels = Level.all.select{|l| l.level_num<level.level_num}
        questions = level.questions.sample(num_new)
        if old_levels.length > 0
            (num_old).times do
                l = old_levels.sample
                # byebug
                questions << l.questions.sample
            end
        else
            (num_old).times {questions << level.questions.sample}
        end
        return questions.shuffle
    end

    def custom_serialize(qs, game, level)
        full_obj = {
            questions:[], 
            game_message: game.intro_message, 
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