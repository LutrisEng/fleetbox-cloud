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

ActiveRecord::Schema[7.0].define(version: 2022_06_15_060924) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "line_item_fields", force: :cascade do |t|
    t.decimal "decimal_value"
    t.text "string_value"
    t.boolean "boolean_value"
    t.text "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "line_item_id", null: false
    t.bigint "tire_set_value_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["line_item_id"], name: "index_line_item_fields_on_line_item_id"
    t.index ["tire_set_value_id"], name: "index_line_item_fields_on_tire_set_value_id"
    t.index ["type_id"], name: "index_line_item_fields_on_type_id"
    t.index ["uuid"], name: "index_line_item_fields_on_uuid", unique: true
  end

  create_table "line_items", force: :cascade do |t|
    t.text "notes"
    t.bigint "sort_order"
    t.text "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "log_item_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["log_item_id"], name: "index_line_items_on_log_item_id"
    t.index ["type_id"], name: "index_line_items_on_type_id"
    t.index ["uuid"], name: "index_line_items_on_uuid", unique: true
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
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["odometer_reading_id"], name: "index_log_items_on_odometer_reading_id"
    t.index ["performed_at"], name: "index_log_items_on_performed_at"
    t.index ["shop_id"], name: "index_log_items_on_shop_id"
    t.index ["uuid"], name: "index_log_items_on_uuid", unique: true
    t.index ["vehicle_id", "performed_at"], name: "index_log_items_on_vehicle_id_and_performed_at"
    t.index ["vehicle_id"], name: "index_log_items_on_vehicle_id"
  end

  create_table "odometer_readings", force: :cascade do |t|
    t.datetime "performed_at"
    t.boolean "include_time"
    t.bigint "reading"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["performed_at"], name: "index_odometer_readings_on_performed_at"
    t.index ["uuid"], name: "index_odometer_readings_on_uuid", unique: true
    t.index ["vehicle_id", "performed_at"], name: "index_odometer_readings_on_vehicle_id_and_performed_at"
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
    t.bigint "owner_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["owner_id"], name: "index_shops_on_owner_id"
    t.index ["uuid"], name: "index_shops_on_uuid", unique: true
  end

  create_table "tire_sets", force: :cascade do |t|
    t.bigint "aspect_ratio"
    t.bigint "base_miles", default: 0, null: false
    t.bigint "breakin", default: 500
    t.text "construction"
    t.bigint "diameter"
    t.boolean "hidden"
    t.bigint "load_index"
    t.text "make"
    t.text "model"
    t.text "speed_rating"
    t.text "tin"
    t.text "user_display_name"
    t.text "vehicle_type"
    t.bigint "width"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["owner_id"], name: "index_tire_sets_on_owner_id"
    t.index ["uuid"], name: "index_tire_sets_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.boolean "admin", default: false, null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "timezone", default: "Central Time (US & Canada)", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "breakin"
    t.text "user_display_name"
    t.text "make"
    t.bigint "miles_per_year"
    t.text "model"
    t.text "vin"
    t.text "model_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id", null: false
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["owner_id"], name: "index_vehicles_on_owner_id"
    t.index ["uuid"], name: "index_vehicles_on_uuid", unique: true
    t.index ["vin"], name: "index_vehicles_on_vin"
  end

  create_table "warranties", force: :cascade do |t|
    t.bigint "miles"
    t.bigint "months"
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id"
    t.bigint "tire_set_id"
    t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
    t.index ["tire_set_id"], name: "index_warranties_on_tire_set_id"
    t.index ["uuid"], name: "index_warranties_on_uuid", unique: true
    t.index ["vehicle_id"], name: "index_warranties_on_vehicle_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "line_item_fields", "line_items"
  add_foreign_key "line_item_fields", "tire_sets", column: "tire_set_value_id"
  add_foreign_key "line_items", "log_items"
  add_foreign_key "log_items", "odometer_readings"
  add_foreign_key "log_items", "shops"
  add_foreign_key "log_items", "vehicles"
  add_foreign_key "odometer_readings", "vehicles"
  add_foreign_key "shops", "users", column: "owner_id"
  add_foreign_key "tire_sets", "users", column: "owner_id"
  add_foreign_key "vehicles", "users", column: "owner_id"
  add_foreign_key "warranties", "tire_sets"
  add_foreign_key "warranties", "vehicles"
end
