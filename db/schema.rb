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

ActiveRecord::Schema.define(version: 20141104140841) do

  create_table "employees", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "office_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_name"
    t.string   "password_digest"
    t.boolean  "admin"
  end

  add_index "employees", ["admin"], name: "index_employees_on_admin"
  add_index "employees", ["user_name"], name: "index_employees_on_user_name", unique: true

  create_table "offices", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tickets", force: true do |t|
    t.text     "description"
    t.integer  "employee_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "system"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
