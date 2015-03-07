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

ActiveRecord::Schema.define(version: 20150307002609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "accounts", force: :cascade do |t|
    t.integer  "default_provider_id", null: false
    t.integer  "virtual_system_id",   null: false
    t.string   "virtual_system_type", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "accounts", ["default_provider_id"], name: "index_accounts_on_default_provider_id", using: :btree
  add_index "accounts", ["virtual_system_type", "virtual_system_id"], name: "index_accounts_on_virtual_system_type_and_virtual_system_id", using: :btree

  create_table "dimension_sample_multi_measures", force: :cascade do |t|
    t.string   "socrata_provider_id", null: false
    t.string   "measure_id",          null: false
    t.string   "column_name",         null: false
    t.string   "value",               null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "dataset_id",          null: false
  end

  create_table "dimension_sample_single_measures", force: :cascade do |t|
    t.string   "socrata_provider_id", null: false
    t.string   "dataset_id",          null: false
    t.string   "column_name",         null: false
    t.string   "value",               null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "dimension_sample_single_measures", ["socrata_provider_id", "dataset_id", "column_name"], name: "index_dimension_sample_single_measures_unique", unique: true, using: :btree

  create_table "features", force: :cascade do |t|
    t.string   "key",                        null: false
    t.boolean  "enabled",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "hospital_systems", force: :cascade do |t|
    t.string "name", null: false
  end

  add_index "hospital_systems", ["name"], name: "index_hospital_systems_on_name", using: :btree

  create_table "log_lines", force: :cascade do |t|
    t.string   "heroku_request_id", null: false
    t.text     "data",              null: false
    t.datetime "logged_at",         null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "old_passwords", force: :cascade do |t|
    t.string   "encrypted_password",       null: false
    t.string   "password_salt"
    t.string   "password_archivable_type", null: false
    t.integer  "password_archivable_id",   null: false
    t.datetime "created_at"
  end

  add_index "old_passwords", ["password_archivable_type", "password_archivable_id"], name: "index_password_archivable", using: :btree

  create_table "pristine_examples", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: :cascade do |t|
    t.string  "name",                null: false
    t.string  "zip_code",            null: false
    t.string  "hospital_type",       null: false
    t.string  "socrata_provider_id", null: false
    t.string  "state",               null: false
    t.string  "city",                null: false
    t.integer "hospital_system_id"
  end

  add_index "providers", ["city", "state"], name: "index_providers_on_city_and_state", using: :btree
  add_index "providers", ["hospital_system_id"], name: "index_providers_on_hospital_system_id", using: :btree
  add_index "providers", ["state"], name: "index_providers_on_state", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                             null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",                   default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.boolean  "is_dabo_admin",                     default: false, null: false
    t.integer  "account_id"
    t.datetime "password_changed_at"
    t.string   "unique_session_id",      limit: 20
  end

  add_index "users", ["account_id"], name: "index_users_on_account_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
