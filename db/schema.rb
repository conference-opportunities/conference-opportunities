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

ActiveRecord::Schema.define(version: 20160412233955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.boolean  "has_travel_funding"
    t.boolean  "has_lodging_funding"
    t.boolean  "has_honorariums"
    t.boolean  "has_diversity_scholarships"
    t.string   "uid",                        null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
  end

  add_index "conferences", ["twitter_handle"], name: "index_conferences_on_twitter_handle", unique: true, using: :btree
  add_index "conferences", ["uid"], name: "index_conferences_on_uid", unique: true, using: :btree

  create_table "organizer_conferences", force: :cascade do |t|
    t.integer  "organizer_id",  null: false
    t.integer  "conference_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "organizer_conferences", ["conference_id"], name: "index_organizer_conferences_on_conference_id", unique: true, using: :btree
  add_index "organizer_conferences", ["organizer_id"], name: "index_organizer_conferences_on_organizer_id", unique: true, using: :btree

  create_table "organizers", force: :cascade do |t|
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "organizers", ["provider", "uid"], name: "index_organizers_on_provider_and_uid", unique: true, using: :btree

  create_table "tweets", force: :cascade do |t|
    t.integer  "conference_id", null: false
    t.string   "twitter_id",    null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "tweets", ["conference_id", "twitter_id"], name: "index_tweets_on_conference_id_and_twitter_id", unique: true, using: :btree

  add_foreign_key "organizer_conferences", "conferences"
  add_foreign_key "organizer_conferences", "organizers"
end
