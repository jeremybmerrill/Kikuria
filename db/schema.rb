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

ActiveRecord::Schema.define(:version => 20120222025926) do

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
  end

end
