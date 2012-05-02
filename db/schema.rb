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

ActiveRecord::Schema.define(:version => 20120501070637) do

  create_table "audios", :force => true do |t|
    t.string   "description"
    t.string   "link"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lexemes", :force => true do |t|
    t.string   "token"
    t.string   "gloss"
    t.string   "pos"
    t.string   "root"
    t.string   "sgNounClassMorpheme"
    t.integer  "sgNounClassNumber"
    t.integer  "plNounClassNumber"
    t.string   "classOrGroup"
    t.string   "transcription"
    t.datetime "editDate"
    t.string   "sgTranscription"
    t.string   "plTranscription"
    t.string   "infTranscription"
    t.text     "additionalForms"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "plNounClassMorpheme"
    t.integer  "user_id"
    t.boolean  "basicWord",           :default => false
    t.integer  "audio_id"
  end

  create_table "syntagms", :force => true do |t|
    t.string   "token"
    t.string   "gloss"
    t.boolean  "grammatical"
    t.string   "classOrGroup"
    t.string   "notes"
    t.datetime "editDate"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "audio_id"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "displayname"
    t.string   "profilestuff"
    t.string   "preferredOrth"
    t.boolean  "admin",                  :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
