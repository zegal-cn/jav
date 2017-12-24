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

ActiveRecord::Schema.define(version: 20171213124655) do

  create_table "actresses", force: :cascade do |t|
    t.integer "cid", null: false
    t.string "name", default: ""
    t.string "name_cn", default: ""
    t.string "name_en", default: ""
    t.string "avatar", default: ""
    t.integer "count", default: 0
    t.integer "rate", default: 0
    t.text "description", default: ""
    t.text "description_cn", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cid"], name: "index_actresses_on_cid"
  end

  create_table "companies", force: :cascade do |t|
    t.integer "cid"
    t.string "name"
    t.string "logo"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "makers", force: :cascade do |t|
    t.integer "cid", null: false
    t.string "name", default: ""
    t.string "name_cn", default: ""
    t.string "name_en", default: ""
    t.string "logo", default: ""
    t.integer "rate", default: 0
    t.text "description"
    t.text "description_cn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cid"], name: "index_makers_on_cid"
  end

end
