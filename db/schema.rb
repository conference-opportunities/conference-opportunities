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

ActiveRecord::Schema.define(version: 20160311202259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conference_organizers", force: :cascade do |t|
    t.string   "provider",      null: false
    t.string   "uid",           null: false
    t.integer  "conference_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "conference_organizers", ["conference_id"], name: "index_conference_organizers_on_conference_id", unique: true, using: :btree
  add_index "conference_organizers", ["provider", "uid"], name: "index_conference_organizers_on_provider_and_uid", unique: true, using: :btree

  create_table "conferences", force: :cascade do |t|
    t.string   "twitter_handle",             null: false
    t.string   "logo_url"
    t.string   "name"
    t.string   "location"
    t.string   "website_url"
    t.text     "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.datetime "approved_at"
    t.datetime "cfp_deadline"
    t.string   "cfp_url"
    t.date     "begin_date"
    t.date     "end_date"
    t.boolean  "has_travel_funding"
    t.boolean  "has_lodging_funding"
    t.boolean  "has_honorariums"
    t.boolean  "has_diversity_scholarships"
  end

  add_index "conferences", ["twitter_handle"], name: "index_conferences_on_twitter_handle", unique: true, using: :btree

  create_table "tweets", force: :cascade do |t|
    t.integer  "conference_id", null: false
    t.string   "twitter_id",    null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "tweets", ["conference_id", "twitter_id"], name: "index_tweets_on_conference_id_and_twitter_id", unique: true, using: :btree

end
