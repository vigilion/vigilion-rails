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

ActiveRecord::Schema.define(version: 20150616144544) do

  create_table "agnostic_documents", force: :cascade do |t|
    t.string "attachment_url"
    t.string "attachment_scan_results"
  end

  create_table "carrierwave_documents", force: :cascade do |t|
    t.string "attachment"
    t.string "attachment_scan_results"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "name"
    t.string   "attachment"
    t.string   "attachment_scan_results"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "dragonfly_documents", force: :cascade do |t|
    t.string   "attachment_uid_file_name"
    t.string   "attachment_uid_content_type"
    t.integer  "attachment_uid_file_size"
    t.datetime "attachment_uid_updated_at"
    t.string   "attachment_scan_results"
  end

  create_table "paperclip_documents", force: :cascade do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.string   "attachment_scan_results"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "picture_scan_results"
  end

end
