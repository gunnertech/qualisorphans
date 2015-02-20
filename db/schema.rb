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

ActiveRecord::Schema.define(version: 20150219110507) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assigned_posts", force: :cascade do |t|
    t.integer  "orphan_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "assigned_posts", ["orphan_id"], name: "index_assigned_posts_on_orphan_id", using: :btree
  add_index "assigned_posts", ["post_id"], name: "index_assigned_posts_on_post_id", using: :btree

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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.string   "domain"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "avatar"
    t.string   "photo"
    t.text     "description"
    t.string   "email"
    t.string   "location"
  end

  add_index "organizations", ["domain"], name: "index_organizations_on_domain", unique: true, using: :btree

  create_table "orphans", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "hashtag"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "avatar"
    t.string   "photo"
    t.text     "description"
    t.integer  "organization_id"
  end

  add_index "orphans", ["hashtag"], name: "index_orphans_on_hashtag", unique: true, using: :btree
  add_index "orphans", ["organization_id"], name: "index_orphans_on_organization_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "tweet_id_str"
    t.string   "body"
    t.string   "photo_url"
    t.datetime "tweet_created_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "organization_id"
  end

  add_index "posts", ["organization_id"], name: "index_posts_on_organization_id", using: :btree
  add_index "posts", ["tweet_id_str"], name: "index_posts_on_tweet_id_str", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.string   "uuid"
    t.integer  "user_id"
    t.integer  "orphan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["orphan_id"], name: "index_subscriptions_on_orphan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  add_index "subscriptions", ["uuid"], name: "index_subscriptions_on_uuid", unique: true, using: :btree

  create_table "twitter_accounts", force: :cascade do |t|
    t.string   "username"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "access_token"
    t.string   "access_token_secret"
    t.integer  "organization_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "twitter_accounts", ["organization_id"], name: "index_twitter_accounts_on_organization_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "assigned_posts", "orphans"
  add_foreign_key "assigned_posts", "posts"
  add_foreign_key "subscriptions", "orphans"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "twitter_accounts", "organizations"
end
