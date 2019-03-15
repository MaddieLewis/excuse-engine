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

ActiveRecord::Schema.define(version: 2019_03_14_123743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "creative_excuses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.index ["user_id"], name: "index_creative_excuses_on_user_id"
  end

  create_table "location_excuses", force: :cascade do |t|
    t.string "start_point"
    t.string "end_point"
    t.string "lines_disrupted"
    t.string "disruption_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "journeys", array: true
    t.string "journey_route", array: true
    t.float "start_latitude"
    t.float "start_longitude"
    t.float "end_latitude"
    t.float "end_longitude"
    t.string "transport_mode"
  end

  create_table "reported_excuses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "category"
    t.datetime "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.integer "votes"
    t.index ["user_id"], name: "index_reported_excuses_on_user_id"
  end

  create_table "saved_excuses", force: :cascade do |t|
    t.bigint "user_id"
    t.text "message"
    t.integer "rating"
    t.string "excuse_type"
    t.bigint "excuse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "favorite", default: false
    t.index ["excuse_type", "excuse_id"], name: "index_saved_excuses_on_excuse_type_and_excuse_id"
    t.index ["user_id"], name: "index_saved_excuses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "creative_excuses", "users"
  add_foreign_key "reported_excuses", "users"
  add_foreign_key "saved_excuses", "users"
end
