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

ActiveRecord::Schema.define(:version => 20130225185015) do

  create_table "corrections", :force => true do |t|
    t.string   "proper"
    t.string   "improper"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "corrections", ["proper"], :name => "index_corrections_on_proper", :unique => true

  create_table "settings", :force => true do |t|
    t.string   "var",                      :null => false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", :limit => 30
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "settings", ["thing_type", "thing_id", "var"], :name => "index_settings_on_thing_type_and_thing_id_and_var", :unique => true

  create_table "tweets", :force => true do |t|
    t.string   "tweet"
    t.integer  "author_id"
    t.integer  "editor_id"
    t.datetime "moderation_date"
    t.datetime "publish_date"
    t.boolean  "needs_moderation",   :default => true
    t.boolean  "for_editors",        :default => false
    t.string   "moderation_reasons"
    t.integer  "retweet_count",      :default => 0
    t.string   "twitter_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.text     "permissions"
    t.boolean  "admin",           :default => false
    t.string   "password_digest"
  end

end
