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

ActiveRecord::Schema.define(version: 2020_01_22_202237) do

  create_table "browsers", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.string "note"
    t.integer "device_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["device_id"], name: "index_browsers_on_device_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name"
    t.integer "browser_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["browser_id"], name: "index_sessions_on_browser_id"
  end

  create_table "tabs", force: :cascade do |t|
    t.string "url"
    t.string "domain"
    t.string "title"
    t.integer "session_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["session_id"], name: "index_tabs_on_session_id"
  end

  add_foreign_key "browsers", "devices"
  add_foreign_key "sessions", "browsers"
  add_foreign_key "tabs", "sessions"
end
