# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_10_21_141223) do
  create_schema "heroku_ext"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "agenda_items", force: :cascade do |t|
    t.bigint "agenda_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["agenda_id"], name: "index_agenda_items_on_agenda_id"
  end

  create_table "agendas", force: :cascade do |t|
    t.date "meeting_date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "draft"
    t.index ["user_id"], name: "index_agendas_on_user_id"
  end

  create_table "albergue_children", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.date "birthday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albergue_donations", force: :cascade do |t|
    t.bigint "user_id"
    t.string "plan", default: "plan_EU0tm2nqfqXFYj"
    t.boolean "anonymous", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "child_name"
    t.integer "child_id"
    t.index ["user_id"], name: "index_albergue_donations_on_user_id"
  end

  create_table "anniversaries", id: :serial, force: :cascade do |t|
    t.string "salutation"
    t.string "last_name"
    t.date "marriage"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "yday"
  end

  create_table "attachinary_files", id: :serial, force: :cascade do |t|
    t.integer "attachinariable_id"
    t.string "attachinariable_type"
    t.string "scope"
    t.string "public_id"
    t.string "version"
    t.integer "width"
    t.integer "height"
    t.string "format"
    t.string "resource_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent"
  end

  create_table "books", id: :serial, force: :cascade do |t|
    t.string "author", limit: 255
    t.string "title", limit: 255
    t.string "subject", limit: 255
    t.string "isbn", limit: 255
    t.string "dewey", limit: 255
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.text "description"
    t.string "cutter"
    t.string "url"
    t.index ["author", "title"], name: "index_books_on_author_and_title"
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "donation_id", null: false
    t.string "card_brand"
    t.string "card_last4"
    t.string "card_exp_month"
    t.string "card_exp_year"
    t.string "stripe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["donation_id"], name: "index_cards_on_donation_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.integer "parent_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "donations", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "type"
    t.string "stripe_id"
    t.integer "amount"
    t.integer "dollars"
    t.string "status"
    t.string "memo"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "ens_feeds", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.string "url"
    t.datetime "published_at", precision: nil
    t.string "guid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.date "date"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "quantity"
    t.integer "amount"
    t.string "url"
    t.string "time"
    t.string "photo"
  end

  create_table "formation_talks", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.date "delivered_on"
  end

  create_table "homilists", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "title", limit: 255
    t.string "photo", limit: 255
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "links", force: :cascade do |t|
    t.string "event"
    t.string "time"
    t.datetime "date", precision: nil
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "marriage_talks", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.date "delivered_on"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "members", id: :serial, force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.date "birthday"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "membership_id"
    t.string "username"
    t.string "away_zip"
    t.integer "yday"
  end

  create_table "opportunities", id: :serial, force: :cascade do |t|
    t.string "ministry", limit: 255
    t.string "who", limit: 255
    t.string "what", limit: 255
    t.string "when", limit: 255
    t.string "where", limit: 255
    t.integer "user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "pathways", force: :cascade do |t|
    t.string "image"
    t.date "pubdate"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.string "title"
    t.text "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pledges", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "amount"
    t.string "plan"
    t.string "subscription_id"
    t.string "plan_id", default: "prod_ETteQ8s9Ho9sNW"
    t.string "status"
    t.integer "dollars"
  end

  create_table "posts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
  end

  create_table "pray_fors", force: :cascade do |t|
    t.string "first_name"
    t.string "reason"
    t.string "honey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "cities"
    t.text "background"
    t.text "career"
    t.text "family"
    t.text "lifestyle"
    t.text "civic"
    t.text "church"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "sermons", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.string "cites", limit: 255
    t.text "sermon_body"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "homilist_id"
    t.date "delivered_on"
    t.string "audio"
  end

  create_table "shots", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.date "dob"
    t.string "email"
    t.string "phone"
    t.string "shot_time"
    t.string "status"
    t.string "honey"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stories", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "user_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "story_assignments", force: :cascade do |t|
    t.bigint "story_idea_id", null: false
    t.integer "assigned_to"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["story_idea_id"], name: "index_story_assignments_on_story_idea_id"
  end

  create_table "story_ideas", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "url"
    t.integer "assigned_to"
    t.integer "status"
  end

  create_table "stripe_reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pledge_id"
    t.bigint "donation_id"
    t.integer "amount"
    t.integer "fee"
    t.integer "net"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date_paid"
    t.index ["donation_id"], name: "index_stripe_reports_on_donation_id"
    t.index ["pledge_id"], name: "index_stripe_reports_on_pledge_id"
    t.index ["user_id"], name: "index_stripe_reports_on_user_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer "user_id"
    t.string "q1"
    t.string "q2"
    t.string "q3"
    t.text "a1"
    t.text "a2"
    t.text "a3"
    t.text "added_comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "syllabuses", id: :serial, force: :cascade do |t|
    t.string "year"
    t.string "grade"
    t.string "title1"
    t.string "title2"
    t.string "title3"
    t.string "title4"
    t.string "title5"
    t.string "title6"
    t.string "title7"
    t.string "title8"
    t.string "title9"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "theme"
    t.integer "quarter"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "deadline"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "thankfuls", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", id: :serial, force: :cascade do |t|
    t.decimal "price"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "event_id"
    t.integer "quantity"
    t.integer "amount"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "customer_id"
    t.string "checkout"
    t.string "honey"
    t.string "stripe_id"
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  create_table "todo_items", force: :cascade do |t|
    t.text "description"
    t.boolean "completed"
    t.datetime "completed_at", precision: nil
    t.bigint "todo_list_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["todo_list_id"], name: "index_todo_items_on_todo_list_id"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "completed"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "username", limit: 255
    t.string "avatar"
    t.string "honey"
    t.string "stripe_id"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "roles", default: ["member"], array: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username"
  end

  create_table "vestry_minutes", id: :serial, force: :cascade do |t|
    t.date "date"
    t.text "minutes"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "draft"
  end

  create_table "vnotes", force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vreports", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "user_id"
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "webhook_events", force: :cascade do |t|
    t.string "source"
    t.string "external_id"
    t.json "data"
    t.integer "state", default: 0
    t.text "processing_errors"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_webhook_events_on_external_id"
    t.index ["source", "external_id"], name: "index_webhook_events_on_source_and_external_id"
    t.index ["source"], name: "index_webhook_events_on_source"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "agenda_items", "agendas"
  add_foreign_key "agendas", "users"
  add_foreign_key "albergue_donations", "users"
  add_foreign_key "cards", "donations"
  add_foreign_key "cards", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "donations", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "story_assignments", "story_ideas"
  add_foreign_key "stripe_reports", "donations"
  add_foreign_key "stripe_reports", "pledges"
  add_foreign_key "stripe_reports", "users"
  add_foreign_key "todo_items", "todo_lists"
end
