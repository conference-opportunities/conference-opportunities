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

ActiveRecord::Schema.define(version: 20160813203541) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conferences", force: :cascade do |t|
    t.string   "twitter_handle", null: false
    t.string   "logo_url"
    t.string   "name"
    t.string   "location"
    t.string   "website_url"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.datetime "approved_at"
    t.string   "uid",            null: false
    t.datetime "unfollowed_at"
    t.string   "banner_url"
    t.index ["twitter_handle"], name: "index_conferences_on_twitter_handle", unique: true, using: :btree
    t.index ["uid"], name: "index_conferences_on_uid", unique: true, using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "conference_id",                  null: false
    t.string   "address",                        null: false
    t.float    "latitude",                       null: false
    t.float    "longitude",                      null: false
    t.datetime "starts_at",                      null: false
    t.datetime "ends_at",                        null: false
    t.datetime "call_for_proposals_ends_at",     null: false
    t.string   "call_for_proposals_url"
    t.boolean  "has_travel_funding"
    t.boolean  "has_lodging_funding"
    t.boolean  "has_honorariums"
    t.boolean  "has_diversity_scholarships"
    t.integer  "attendees_count"
    t.integer  "submission_opportunities_count"
    t.integer  "keynotes_count"
    t.integer  "other_talks_count"
    t.integer  "panels_count"
    t.integer  "plenaries_count"
    t.integer  "prior_submissions_count"
    t.integer  "talks_count"
    t.integer  "tracks_count"
    t.integer  "tutorials_count"
    t.integer  "workshops_count"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "hashtag"
    t.string   "code_of_conduct_url"
    t.boolean  "has_childcare"
    t.datetime "speaker_notifications_at",       null: false
    t.index ["conference_id"], name: "index_events_on_conference_id", unique: true, using: :btree
  end

  create_table "organizer_conferences", force: :cascade do |t|
    t.integer  "organizer_id",  null: false
    t.integer  "conference_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["conference_id"], name: "index_organizer_conferences_on_conference_id", unique: true, using: :btree
    t.index ["organizer_id"], name: "index_organizer_conferences_on_organizer_id", unique: true, using: :btree
  end

  create_table "organizers", force: :cascade do |t|
    t.string   "provider",                  null: false
    t.string   "uid",                       null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "locale",     default: "en", null: false
    t.index ["provider", "uid"], name: "index_organizers_on_provider_and_uid", unique: true, using: :btree
  end

  create_table "tweets", force: :cascade do |t|
    t.integer  "conference_id", null: false
    t.string   "twitter_id",    null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["conference_id", "twitter_id"], name: "index_tweets_on_conference_id_and_twitter_id", unique: true, using: :btree
  end

  add_foreign_key "events", "conferences"
  add_foreign_key "organizer_conferences", "conferences"
  add_foreign_key "organizer_conferences", "organizers"
end
