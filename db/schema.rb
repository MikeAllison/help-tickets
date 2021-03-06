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

ActiveRecord::Schema.define(version: 20160111232725) do

  create_table "attachments", force: :cascade do |t|
    t.binary   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",     default: false
    t.string   "slug"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id"

  create_table "comments", force: :cascade do |t|
    t.integer  "ticket_id"
    t.integer  "employee_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_type", default: 0
  end

  add_index "comments", ["employee_id"], name: "index_comments_on_employee_id"
  add_index "comments", ["ticket_id"], name: "index_comments_on_ticket_id"

  create_table "employees", force: :cascade do |t|
    t.string   "fname"
    t.string   "lname"
    t.integer  "office_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "password_digest"
    t.boolean  "technician",      default: false
    t.boolean  "active",          default: false
    t.boolean  "hidden",          default: false
  end

  add_index "employees", ["office_id"], name: "index_employees_on_office_id"

  create_table "offices", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.boolean  "hidden",     default: false
    t.boolean  "active",     default: true
    t.string   "slug"
  end

  add_index "offices", ["city_id"], name: "index_offices_on_city_id"

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "abbreviation", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: :cascade do |t|
    t.text     "description"
    t.integer  "originator_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "technician_id"
    t.integer  "status",        default: 0
    t.integer  "submitter_id"
    t.datetime "closed_at"
    t.integer  "priority",      default: 0
  end

  add_index "tickets", ["originator_id"], name: "index_tickets_on_originator_id"
  add_index "tickets", ["topic_id"], name: "index_tickets_on_topic_id"

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
    t.boolean  "hidden",     default: false
    t.string   "slug"
  end

end
