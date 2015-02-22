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

ActiveRecord::Schema.define(version: 20150222222436) do

  create_table "api_applications", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "api_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_applications", ["api_user_id"], name: "index_api_applications_on_api_user_id"

  create_table "api_keys", force: true do |t|
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "revoked",            default: false
    t.integer  "api_application_id"
  end

  add_index "api_keys", ["api_application_id"], name: "index_api_keys_on_api_application_id"

  create_table "api_requests", force: true do |t|
    t.integer  "api_key_id"
    t.string   "url"
    t.string   "resource"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_requests", ["api_key_id"], name: "index_api_requests_on_api_key_id"

  create_table "api_users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "api_users", ["email"], name: "index_api_users_on_email", unique: true

  create_table "app_urls", force: true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "api_application_id"
  end

  add_index "app_urls", ["api_application_id"], name: "index_app_urls_on_api_application_id"

  create_table "events", force: true do |t|
    t.integer  "position_id"
    t.integer  "user_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["position_id"], name: "index_events_on_position_id"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "events_tags", force: true do |t|
    t.integer  "event_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events_tags", ["event_id"], name: "index_events_tags_on_event_id"
  add_index "events_tags", ["tag_id"], name: "index_events_tags_on_tag_id"

  create_table "places", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.decimal  "lat"
    t.decimal  "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
