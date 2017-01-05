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

ActiveRecord::Schema.define(version: 20170105143418) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_lines", force: :cascade do |t|
    t.string   "title"
    t.datetime "found_date"
    t.string   "activity_type"
    t.string   "description"
    t.integer  "member_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "state"
    t.text     "logo"
    t.text     "organization_type"
  end

  create_table "activity_lines_corporative_arguments", force: :cascade do |t|
    t.integer  "member_id"
    t.text     "text"
    t.text     "argument_type"
    t.integer  "confession_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "state",         default: "active"
  end

  create_table "activity_lines_corporative_confessions", force: :cascade do |t|
    t.integer  "year"
    t.integer  "member_id"
    t.text     "nomination"
    t.text     "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
  end

  create_table "activity_lines_corporative_online_conference_questions", force: :cascade do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "online_conference_id"
    t.text     "state"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.text     "answer_timestamp"
  end

  create_table "activity_lines_corporative_online_conferences", force: :cascade do |t|
    t.text     "title"
    t.datetime "date"
    t.text     "video_link"
    t.text     "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
  end

  create_table "activity_lines_lider_ya_lider_participants", force: :cascade do |t|
    t.integer  "contest_year"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "activity_lines_lider_ya_lider_participations", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "stage_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "state"
  end

  create_table "activity_lines_lider_ya_lider_stages", force: :cascade do |t|
    t.integer  "number"
    t.integer  "ya_lider_id"
    t.text     "title"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "state"
  end

  create_table "activity_lines_lider_ya_liders", force: :cascade do |t|
    t.integer  "contest_number"
    t.integer  "contest_year"
    t.text     "state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "view"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.text     "state"
    t.integer  "category_id"
    t.integer  "user_id"
    t.integer  "views",       default: 0
    t.text     "publicity"
    t.text     "access",      default: "all"
  end

  create_table "articles_documents", id: false, force: :cascade do |t|
    t.integer "article_id"
    t.integer "document_id"
  end

  add_index "articles_documents", ["article_id"], name: "index_articles_documents_on_article_id", using: :btree
  add_index "articles_documents", ["document_id"], name: "index_articles_documents_on_document_id", using: :btree

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

  create_table "banners", force: :cascade do |t|
    t.string   "photo"
    t.string   "link"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "state"
    t.text     "horizontal"
    t.text     "vertical"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "is_last"
    t.text     "state"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "text"
    t.integer  "record_id"
    t.text     "record_type"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.text     "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "delivery_audiences", force: :cascade do |t|
    t.text     "audience_type"
    t.integer  "audience_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "campaign_id"
  end

  create_table "delivery_campaigns", force: :cascade do |t|
    t.text     "title"
    t.text     "body"
    t.text     "image"
    t.text     "link"
    t.integer  "creator_id"
    t.datetime "mailing_date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "state"
  end

  create_table "delivery_contact_emails", force: :cascade do |t|
    t.text     "email"
    t.text     "first_name"
    t.text     "last_name"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "state",      default: "subscribed"
  end

  create_table "documents", force: :cascade do |t|
    t.text     "file"
    t.text     "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "state"
  end

  create_table "documents_news", id: false, force: :cascade do |t|
    t.integer "news_id"
    t.integer "document_id"
  end

  add_index "documents_news", ["document_id"], name: "index_documents_news_on_document_id", using: :btree
  add_index "documents_news", ["news_id"], name: "index_documents_news_on_news_id", using: :btree

  create_table "event_registrations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.string   "role"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "google_calendar_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "main_photo"
    t.integer  "creator_id"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "state"
    t.text     "place"
    t.integer  "activity_line_id"
    t.integer  "organizer_id"
    t.text     "organizer_type"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "url"
    t.text     "text"
    t.text     "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "functional_yofications", force: :cascade do |t|
    t.text     "body"
    t.text     "yoficated_body"
    t.integer  "user_id"
    t.text     "status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "images", force: :cascade do |t|
    t.text     "file"
    t.datetime "date"
    t.integer  "author_id"
    t.text     "author_name"
    t.text     "image_type"
    t.text     "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "letters", force: :cascade do |t|
    t.text     "subdivision_code"
    t.integer  "number"
    t.datetime "send_date"
    t.text     "receiver"
    t.text     "title"
    t.integer  "list_number"
    t.integer  "annex"
    t.integer  "executor_id"
    t.text     "stamp_of_receipt"
    t.text     "note"
    t.text     "state"
    t.text     "executor_name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "file"
  end

  create_table "logged_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "action_type"
    t.text     "record_type"
    t.integer  "record_id"
    t.text     "params"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "published_at"
    t.text     "photo"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "state"
    t.text     "lead"
    t.integer  "views",        default: 0
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "oauth_apps", force: :cascade do |t|
    t.text     "title"
    t.text     "client_id"
    t.text     "client_secret"
    t.text     "url"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "state"
    t.text     "callback_url"
  end

  create_table "pages", force: :cascade do |t|
    t.text     "title"
    t.text     "view"
    t.text     "size"
    t.text     "text"
    t.text     "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "positions", force: :cascade do |t|
    t.text     "title"
    t.integer  "member_id"
    t.datetime "begin_date"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "end_date"
    t.text     "for_now"
    t.text     "state"
    t.text     "status",     default: "confirmed"
  end

  create_table "redirect_rules", force: :cascade do |t|
    t.text     "old_path"
    t.text     "redirect_to"
    t.text     "status"
    t.text     "reason"
    t.text     "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "receiver_id"
    t.text     "subscription_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "receiver_type"
  end

  create_table "tags", force: :cascade do |t|
    t.text     "text"
    t.text     "tag_type"
    t.integer  "record_id"
    t.string   "record_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "state"
  end

  add_index "tags", ["record_type", "record_id"], name: "index_tags_on_record_type_and_record_id", using: :btree
  add_index "tags", ["target_type", "target_id"], name: "index_tags_on_target_type_and_target_id", using: :btree

  create_table "team_administrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_departaments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "team_subdivisions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "title"
    t.integer  "member_id"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "state"
    t.text     "municipality"
    t.text     "type"
    t.text     "school"
    t.integer  "team_id"
    t.text     "publicity"
  end

  create_table "teams_users", id: false, force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
  end

  create_table "test_papers", force: :cascade do |t|
    t.text     "title"
    t.datetime "begin_date"
    t.datetime "end_date"
    t.integer  "record_id"
    t.text     "record_type"
    t.text     "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.text     "content"
    t.integer  "record_id"
    t.text     "record_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
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
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.datetime "join_date"
    t.text     "token"
    t.text     "school"
    t.text     "member_state",    default: "unviewed"
    t.datetime "request_date"
    t.text     "corporate_email"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "difference"
    t.integer  "user_id"
    t.integer  "target_id"
    t.text     "target_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
