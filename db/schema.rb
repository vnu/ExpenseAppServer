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

ActiveRecord::Schema.define(version: 20130922200657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "display_name"
    t.decimal  "balance",      precision: 10, scale: 2, default: 0.0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shared_transactions", force: true do |t|
    t.integer  "vendor_id",                                               null: false
    t.integer  "transaction_id",                                          null: false
    t.text     "notes"
    t.boolean  "owner",                                   default: false
    t.decimal  "amount",         precision: 10, scale: 2
    t.integer  "user_id",                                                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transaction_types", force: true do |t|
    t.string   "display_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "vendor_id",                                    null: false
    t.integer  "account_id",                                   null: false
    t.text     "notes"
    t.datetime "transaction_date"
    t.integer  "transaction_type_id",                          null: false
    t.decimal  "amount",              precision: 10, scale: 2
    t.integer  "user_id",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",              null: false
    t.string   "email"
    t.string   "twitter_user_name", null: false
    t.string   "twitter_uid",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: true do |t|
    t.string   "display_name", null: false
    t.integer  "user_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
