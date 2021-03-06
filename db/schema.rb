# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140517204107) do

  create_table "admin_users", force: true do |t|
    t.string   "name",              null: false
    t.string   "email",             null: false
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token"
  end

  add_index "admin_users", ["perishable_token"], name: "index_admin_users_on_perishable_token", using: :btree

  create_table "log_book_events", force: true do |t|
    t.integer  "historian_id"
    t.string   "historian_type"
    t.integer  "historizable_id"
    t.string   "historizable_type"
    t.text     "text",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "online_purchases", force: true do |t|
    t.integer  "short_film_user_id",                         null: false
    t.decimal  "amount",             precision: 8, scale: 2, null: false
    t.datetime "paid_at"
    t.datetime "canceled_at"
    t.string   "error"
    t.string   "token"
    t.string   "payer_id"
    t.string   "description",                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "short_film_users", force: true do |t|
    t.string   "title",                  null: false
    t.integer  "length_minutes",         null: false
    t.integer  "length_seconds",         null: false
    t.string   "language",               null: false
    t.text     "script_embed"
    t.string   "subtitles_language"
    t.string   "genre",                  null: false
    t.string   "credits_script"
    t.string   "credits_camera"
    t.string   "credits_art_direction"
    t.string   "credits_editing"
    t.string   "credits_music"
    t.string   "credits_other"
    t.text     "credits_actors"
    t.text     "synopsis",               null: false
    t.string   "director_name",          null: false
    t.string   "director_dni",           null: false
    t.string   "director_phone",         null: false
    t.string   "director_email",         null: false
    t.string   "school_name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "perishable_token"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "moderation_accepted"
    t.datetime "received_at"
    t.datetime "paid_at"
    t.string   "tutor_kind"
    t.string   "tutor_name"
    t.string   "tutor_dni"
    t.string   "tutor_phone"
    t.string   "tutor_email"
    t.date     "director_date_of_birth", null: false
    t.boolean  "accept_authenticity"
    t.boolean  "accept_authorization"
    t.boolean  "accept_responsability"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

end
