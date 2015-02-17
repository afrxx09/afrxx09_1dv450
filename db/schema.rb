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

ActiveRecord::Schema.define(version: 20150217103710) do

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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "revoked",    default: false
  end

  add_index "api_keys", ["user_id", "key"], name: "index_api_keys_on_user_id_and_key"
  add_index "api_keys", ["user_id"], name: "index_api_keys_on_user_id"

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

end
