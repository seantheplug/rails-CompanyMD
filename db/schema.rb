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

ActiveRecord::Schema.define(version: 2019_08_21_075855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ticker"
    t.string "times", default: [], array: true
    t.float "prices", default: [], array: true
  end

  create_table "companies_pointers", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "company_id"
    t.float "portion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_companies_pointers_on_company_id"
    t.index ["group_id"], name: "index_companies_pointers_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "user_setting"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "market_indices", force: :cascade do |t|
    t.string "name"
    t.string "ticker"
    t.float "price"
    t.float "high"
    t.float "low"
    t.float "change"
    t.float "change_percent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "companies_pointers", "companies"
  add_foreign_key "companies_pointers", "groups"
  add_foreign_key "groups", "users"
end
