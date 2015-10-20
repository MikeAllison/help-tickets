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

ActiveRecord::Schema.define(version: 20151020155702) do

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
    t.string   "slug"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id"

  create_table "comments", force: true do |t|
    t.integer  "ticket:active_tech"
    t.integer  "employee:active_tech"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_type", default: 0
  end

  add_index "comments", ["employee:active_tech"], name: "index_comments_on_employee:active_tech"
  add_index "comments", ["ticket:active_tech"], name: "index_comments_on_ticket:active_tech"

  create_table "employees", force: true do |t|
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

  create_table "offices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  ":city_id"
    t.boolean  "hidden",     default: false
    t.boolean  "active",     default: true
    t.string   "slug"
  end

  add_index "offices", [":city_id"], name: "index_offices_on_:city_id"

  create_table "states", force: true do |t|
    t.string   "name"
    t.string   "abbreviation", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.text     "description"
    t.integer  "originator:active_tech"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "technician_id"
    t.integer  "status",        default: 0
    t.integer  "submitter:active_tech"
  end

  add_index "tickets", ["originator:active_tech"], name: "index_tickets_on_originator:active_tech"
  add_index "tickets", ["topic_id"], name: "index_tickets_on_topic_id"

  create_table "topics", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: true
    t.boolean  "hidden",     default: false
    t.string   "slug"
  end

end
