# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_06_01_050619) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "line_item_fields", force: :cascade do |t|
    t.decimal "decimal_value"
    t.text "string_value"
    t.text "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "line_item_id", null: false
    t.bigint "tire_set_value_id"
    t.index ["line_item_id"], name: "index_line_item_fields_on_line_item_id"
    t.index ["tire_set_value_id"], name: "index_line_item_fields_on_tire_set_value_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.text "notes"
    t.decimal "sort_order"
    t.text "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "log_item_id", null: false
    t.index ["log_item_id"], name: "index_line_items_on_log_item_id"
  end

  create_table "log_items", force: :cascade do |t|
    t.text "display_name"
    t.boolean "include_time"
    t.datetime "performed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id", null: false
    t.bigint "shop_id"
    t.bigint "odometer_reading_id"
    t.index ["odometer_reading_id"], name: "index_log_items_on_odometer_reading_id"
    t.index ["shop_id"], name: "index_log_items_on_shop_id"
    t.index ["vehicle_id"], name: "index_log_items_on_vehicle_id"
  end

  create_table "odometer_readings", force: :cascade do |t|
    t.datetime "at"
    t.boolean "include_time"
    t.decimal "reading"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id", null: false
    t.index ["vehicle_id"], name: "index_odometer_readings_on_vehicle_id"
  end

  create_table "shops", force: :cascade do |t|
    t.text "email"
    t.text "location"
    t.text "name"
    t.text "notes"
    t.text "phone_number"
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tire_sets", force: :cascade do |t|
    t.decimal "aspect_ratio"
    t.decimal "base_miles"
    t.decimal "breakin"
    t.text "construction"
    t.decimal "diameter"
    t.boolean "hidden"
    t.decimal "load_index"
    t.text "make"
    t.text "model"
    t.text "speed_rating"
    t.text "tin"
    t.text "user_display_name"
    t.text "vehicle_type"
    t.decimal "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.decimal "breakin"
    t.text "display_name"
    t.text "make"
    t.decimal "miles_per_year"
    t.text "model"
    t.text "vin"
    t.text "model_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "warranties", force: :cascade do |t|
    t.decimal "miles"
    t.decimal "months"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id"
    t.bigint "tire_set_id"
    t.index ["tire_set_id"], name: "index_warranties_on_tire_set_id"
    t.index ["vehicle_id"], name: "index_warranties_on_vehicle_id"
  end

  add_foreign_key "line_item_fields", "line_items"
  add_foreign_key "line_item_fields", "tire_sets", column: "tire_set_value_id"
  add_foreign_key "line_items", "log_items"
  add_foreign_key "log_items", "odometer_readings"
  add_foreign_key "log_items", "shops"
  add_foreign_key "log_items", "vehicles"
  add_foreign_key "odometer_readings", "vehicles"
  add_foreign_key "warranties", "tire_sets"
  add_foreign_key "warranties", "vehicles"
end
