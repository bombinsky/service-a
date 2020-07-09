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

ActiveRecord::Schema.define(version: 2020_07_04_215829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "external_urls", force: :cascade do |t|
    t.bigint "external_urls_request_id", null: false
    t.string "page_title", null: false
    t.string "url", null: false
    t.index ["external_urls_request_id", "url"], name: "index_external_urls_on_external_urls_request_id_and_url", unique: true
    t.index ["external_urls_request_id"], name: "index_external_urls_on_external_urls_request_id"
  end

  create_table "external_urls_requests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "status", default: 0, null: false
    t.string "email", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_external_urls_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "nickname", null: false
    t.string "email"
    t.string "token", null: false
    t.string "secret", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
  end

  add_foreign_key "external_urls", "external_urls_requests"
  add_foreign_key "external_urls_requests", "users"
end
