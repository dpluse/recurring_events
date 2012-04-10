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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120311175810) do

  create_table "event_periods", :force => true do |t|
    t.integer  "seq_no"
    t.string   "name"
    t.integer  "scale"
    t.text     "description"
    t.datetime "created_at"
    t.integer  "created_by_user_id"
    t.integer  "updated_by_user_id"
    t.datetime "updated_at"
  end

  create_table "timetable_event_periods", :force => true do |t|
    t.integer  "seq_no"
    t.integer  "timetable_id"
    t.string   "next_event"
    t.string   "end_event"
    t.datetime "created_at"
    t.integer  "created_by_user_id"
    t.integer  "updated_by_user_id"
    t.datetime "updated_at"
  end

  create_table "timetable_event_rules", :force => true do |t|
    t.integer  "seq_no"
    t.integer  "timetable_event_period_id"
    t.integer  "event_period_recurrance"
    t.integer  "event_period_number"
    t.integer  "event_period_id"
    t.datetime "created_at"
    t.integer  "created_by_user_id"
    t.integer  "updated_by_user_id"
    t.datetime "updated_at"
  end

  create_table "timetable_periods", :force => true do |t|
    t.integer  "seq_no"
    t.string   "name"
    t.integer  "scale"
    t.text     "description"
    t.datetime "created_at"
    t.integer  "created_by_user_id"
    t.integer  "updated_by_user_id"
    t.datetime "updated_at"
  end

  create_table "timetables", :force => true do |t|
    t.string   "name"
    t.integer  "timetable_period_id"
    t.datetime "created_at"
    t.integer  "created_by_user_id"
    t.integer  "updated_by_user_id"
    t.datetime "updated_at"
  end

end
