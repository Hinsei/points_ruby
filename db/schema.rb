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

ActiveRecord::Schema.define(version: 2018_06_02_102728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "brands", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.bigint "customer_id"
    t.uuid "brand_id"
    t.integer "collected_points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_collections_on_brand_id"
    t.index ["customer_id"], name: "index_collections_on_customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "outlets", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest"
    t.uuid "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_outlets_on_brand_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "cost"
    t.uuid "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_promotions_on_brand_id"
  end

  create_table "redemptions", force: :cascade do |t|
    t.bigint "outlet_id"
    t.bigint "promotion_id"
    t.bigint "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_redemptions_on_customer_id"
    t.index ["outlet_id"], name: "index_redemptions_on_outlet_id"
    t.index ["promotion_id"], name: "index_redemptions_on_promotion_id"
  end

end
