# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_23_202157) do

  create_table "chord_levels", force: :cascade do |t|
    t.integer "chord_id"
    t.integer "level_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chord_notes", force: :cascade do |t|
    t.integer "chord_id"
    t.integer "note_id"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chords", force: :cascade do |t|
    t.string "roman_numeral"
    t.string "chord_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.boolean "order_matters", default: false
    t.string "intro_message", default: ""
    t.string "intro_sound_url", default: ""
    t.boolean "play_first", default: false
    t.boolean "chords_allowed", default: false
    t.boolean "list_note_names", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "levels", force: :cascade do |t|
    t.integer "level_num"
    t.integer "game_id"
    t.boolean "arpeggiated", default: true
    t.string "level_message"
    t.string "level_message_sound_url", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "note_questions", force: :cascade do |t|
    t.integer "note_id"
    t.integer "question_id"
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "notes", force: :cascade do |t|
    t.string "note_value"
    t.string "solfege_value"
    t.string "pitch_name"
    t.string "note_name_sound_url", default: ""
    t.string "solfege_sound_url", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer "level_id"
    t.string "question_text"
    t.string "sound_url", default: ""
    t.boolean "use_solfege", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_levels", force: :cascade do |t|
    t.boolean "completed", default: false
    t.integer "best_score", default: 0
    t.integer "level_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
