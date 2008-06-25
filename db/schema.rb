# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080611180354) do

  create_table "albums", :force => true do |t|
    t.integer  "artist_id",   :limit => 11
    t.string   "name"
    t.integer  "year",        :limit => 11
    t.datetime "created_at"
    t.datetime "modified_at"
  end

  add_index "albums", ["artist_id"], :name => "index_albums_on_artist_id"

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "genre"
    t.datetime "created_at"
    t.datetime "modified_at"
  end

  create_table "lyrics", :force => true do |t|
    t.string  "title"
    t.string  "artist"
    t.string  "album"
    t.integer "year",   :limit => 11
    t.integer "track",  :limit => 11
    t.string  "genre"
    t.text    "body"
  end

  create_table "songs", :force => true do |t|
    t.integer  "artist_id",   :limit => 11
    t.integer  "album_id",    :limit => 11
    t.string   "title"
    t.text     "body"
    t.integer  "track",       :limit => 11
    t.datetime "created_at"
    t.datetime "modified_at"
  end

  add_index "songs", ["artist_id"], :name => "index_songs_on_artist_id"
  add_index "songs", ["album_id"], :name => "index_songs_on_album_id"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
