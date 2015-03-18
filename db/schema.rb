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

ActiveRecord::Schema.define(version: 20150310003517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attribute_accesses", force: :cascade do |t|
    t.integer  "member_id"
    t.text     "member_attribute"
    t.text     "access"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "authentications", force: :cascade do |t|
    t.text     "provider"
    t.text     "uid"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "published_at"
    t.text     "photo"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "state"
    t.text     "lead"
  end

  create_table "positions", force: :cascade do |t|
    t.text     "title"
    t.integer  "member_id"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "password_digest"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "patronymic"
    t.integer  "user_id"
    t.text     "motto"
    t.integer  "ticket"
    t.integer  "parent_id"
    t.text     "mobile_phone"
    t.datetime "birth_date"
    t.text     "home_adress"
    t.text     "municipality"
    t.text     "locality"
    t.text     "avatar"
    t.text     "role"
    t.text     "state"
    t.text     "experience"
    t.text     "want_to_do"
    t.string   "type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
