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

ActiveRecord::Schema.define(version: 20160828170519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "battles", force: :cascade do |t|
    t.integer  "winner_score"
    t.integer  "loser_score"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "winner_id"
    t.integer  "loser_id"
    t.index ["loser_id"], name: "index_battles_on_loser_id", using: :btree
    t.index ["winner_id"], name: "index_battles_on_winner_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "github_id"
    t.string   "login"
    t.string   "avatar_url"
    t.string   "blog"
    t.string   "github_created_at"
    t.integer  "followers"
    t.integer  "following"
    t.integer  "public_repos"
    t.integer  "public_gists"
    t.string   "location"
    t.string   "company"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "github_url"
    t.string   "kind"
    t.string   "bio"
  end

end
