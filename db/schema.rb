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

ActiveRecord::Schema.define(version: 2018_08_25_001147) do

  create_table "rates", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id"], name: "index_rates_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "box_type"
    t.string "title"
    t.string "slug"
    t.string "short_title"
    t.text "marketing_description"
    t.integer "calories_kcal"
    t.integer "protein_grams"
    t.integer "fat_grams"
    t.integer "carbs_grams"
    t.string "bulletpoint1"
    t.string "bulletpoint2"
    t.string "bulletpoint3"
    t.string "recipe_diet_type_id"
    t.string "season"
    t.string "base"
    t.string "protein_source"
    t.integer "preparation_time_minutes"
    t.integer "shelf_life_days"
    t.string "equipment_needed"
    t.string "origin_country"
    t.string "recipe_cuisine"
    t.text "in_your_box"
    t.integer "gousto_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rate"
  end

end
