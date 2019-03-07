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

ActiveRecord::Schema.define(version: 2019_03_06_125522) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "creative_excuses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "photo"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  create_table "saved_excuses", force: :cascade do |t|
    t.bigint "user_id"
    t.text "message"
    t.integer "rating"
    t.string "excuse_type"
    t.bigint "excuse_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "creative_excuses", "users"
  add_foreign_key "saved_excuses", "users"
end
