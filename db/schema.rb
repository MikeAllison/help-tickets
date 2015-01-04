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

ActiveRecord::Schema.define(version: 20150104205955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: true do |t|
    t.binary   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",     default: false
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "ticket_id"
    t.integer  "employee_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closing_comment",   default: false
    t.boolean  "reopening_comment", default: false
  end

  create_table "employees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "office_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "password_digest"
    t.boolean  "admin",           default: false
    t.boolean  "active",          default: false
    t.boolean  "hidden",          default: false
  end

  add_index "employees", ["admin"], name: "index_employees_on_admin", using: :btree
  add_index "employees", ["user_name"], name: "index_employees_on_user_name", unique: true, using: :btree

  create_table "offices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.boolean  "hidden",     default: false
    t.boolean  "active",     default: true
  end

  add_index "offices", ["city_id"], name: "index_offices_on_city_id", using: :btree

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "abbreviation", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.text     "description"
    t.integer  "creator_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
    t.integer  "technician_id"
  end

  add_index "tickets", ["status_id"], name: "index_tickets_on_status_id", using: :btree
  add_index "tickets", ["technician_id"], name: "index_tickets_on_technician_id", using: :btree

  create_table "topics", force: true do |t|
    t.string   "system"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
    t.boolean  "hidden",     default: false
  end

end
