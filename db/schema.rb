# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_26_142533) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "preferences", force: :cascade do |t|
    t.string "currency", default: "$"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label_text", default: "Per Unit:"
    t.string "delimiter", default: "."
    t.string "insert_order"
    t.string "variant_label_text"
    t.string "collection_label_text", default: "Click here for more details"
    t.index ["shop_id"], name: "index_preferences_on_shop_id"
  end

  create_table "products", force: :cascade do |t|
    t.text "title"
    t.string "shopify_id", limit: 8
    t.float "units"
    t.float "product_price"
    t.float "unit_price"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_url"
    t.string "shopify_metafield_id"
    t.string "unit_name"
    t.index ["shop_id"], name: "index_products_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "charge_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email_address"
    t.boolean "theme_scope_enabled", default: true
    t.boolean "snippet_locked", default: false
    t.string "access_scopes"
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.text "title"
    t.string "shopify_id"
    t.float "units"
    t.float "variant_price"
    t.float "unit_price"
    t.integer "product_id"
    t.string "shopify_metafield_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "image_url"
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  create_table "widgets", force: :cascade do |t|
    t.string "name"
    t.integer "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "preferences", "shops"
  add_foreign_key "products", "shops"
  add_foreign_key "variants", "products"
end
