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

ActiveRecord::Schema.define(version: 20190819150505) do

  create_table "beers", force: :cascade do |t|
    t.integer "brewery_id"
    t.string  "name"
    t.string  "style"
    t.string  "additions"
    t.float   "abv"
  end

  create_table "breweries", force: :cascade do |t|
    t.string  "name"
    t.string  "location"
    t.string  "specialty"
    t.integer "year_founded"
  end

  create_table "consumer_beers", force: :cascade do |t|
    t.integer "beer_id"
    t.integer "consumer_id"
    t.integer "num_consumed",  default: 0
    t.integer "num_available"
    t.float   "size"
    t.string  "packaging"
    t.date    "exp_date"
    t.float   "rating"
  end

  create_table "consumers", force: :cascade do |t|
    t.string  "name"
    t.integer "age"
    t.string  "location"
    t.string  "gender"
    t.string  "favorite_style"
  end

end
