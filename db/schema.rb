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

ActiveRecord::Schema.define(version: 20150925153522) do

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "abbreviations"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "chapters", ["book_id"], name: "index_chapters_on_book_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "highlights", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "verse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "highlights", ["user_id"], name: "index_highlights_on_user_id"
  add_index "highlights", ["verse_id"], name: "index_highlights_on_verse_id"

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "section_verses", force: :cascade do |t|
    t.integer  "section_id"
    t.integer  "verse_id"
    t.integer  "parent_id"
    t.integer  "lft",        null: false
    t.integer  "rgt",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "section_verses", ["lft"], name: "index_section_verses_on_lft"
  add_index "section_verses", ["parent_id"], name: "index_section_verses_on_parent_id"
  add_index "section_verses", ["rgt"], name: "index_section_verses_on_rgt"
  add_index "section_verses", ["section_id"], name: "index_section_verses_on_section_id"
  add_index "section_verses", ["verse_id"], name: "index_section_verses_on_verse_id"

  create_table "sections", force: :cascade do |t|
    t.integer  "study_id"
    t.string   "title"
    t.text     "notes"
    t.integer  "parent_id"
    t.integer  "lft",        null: false
    t.integer  "rgt",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sections", ["lft"], name: "index_sections_on_lft"
  add_index "sections", ["parent_id"], name: "index_sections_on_parent_id"
  add_index "sections", ["rgt"], name: "index_sections_on_rgt"
  add_index "sections", ["study_id"], name: "index_sections_on_study_id"

  create_table "studies", force: :cascade do |t|
    t.boolean  "active",                  default: true
    t.integer  "user_id"
    t.string   "title"
    t.string   "permalink"
    t.text     "description"
    t.integer  "cached_views_total",      default: 0
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.float    "float",                   default: 0.0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "studies", ["cached_views_total"], name: "index_studies_on_cached_views_total"
  add_index "studies", ["cached_votes_down"], name: "index_studies_on_cached_votes_down"
  add_index "studies", ["cached_votes_score"], name: "index_studies_on_cached_votes_score"
  add_index "studies", ["cached_votes_total"], name: "index_studies_on_cached_votes_total"
  add_index "studies", ["cached_votes_up"], name: "index_studies_on_cached_votes_up"
  add_index "studies", ["cached_weighted_average"], name: "index_studies_on_cached_weighted_average"
  add_index "studies", ["cached_weighted_score"], name: "index_studies_on_cached_weighted_score"
  add_index "studies", ["cached_weighted_total"], name: "index_studies_on_cached_weighted_total"
  add_index "studies", ["float"], name: "index_studies_on_float"
  add_index "studies", ["user_id"], name: "index_studies_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "uid"
    t.string   "provider"
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "active",                 default: true
    t.string   "name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "bio"
    t.string   "website"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "time_zone"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["provider"], name: "index_users_on_provider", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

  create_table "verses", force: :cascade do |t|
    t.integer  "chapter_id"
    t.integer  "number"
    t.integer  "page"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "verses", ["chapter_id"], name: "index_verses_on_chapter_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
