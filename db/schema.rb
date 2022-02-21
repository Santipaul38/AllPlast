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

ActiveRecord::Schema.define(version: 2022_02_21_195415) do

  create_table "bill_items", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bill_id", null: false
    t.integer "sale_detail_id", null: false
    t.index ["bill_id"], name: "index_bill_items_on_bill_id"
    t.index ["sale_detail_id"], name: "index_bill_items_on_sale_detail_id"
  end

  create_table "bills", force: :cascade do |t|
    t.float "total"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sale_id", null: false
    t.datetime "date", precision: 6
    t.index ["sale_id"], name: "index_bills_on_sale_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "category_products", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_id", null: false
    t.integer "product_id", null: false
    t.index ["category_id"], name: "index_category_products_on_category_id"
    t.index ["product_id"], name: "index_category_products_on_product_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "business"
    t.integer "phone_number"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "price_lists", force: :cascade do |t|
    t.datetime "date", precision: 6
    t.float "percentage"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "expiration_date", precision: 6
    t.string "name"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.integer "stock"
    t.datetime "registration_date", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "state"
    t.integer "max_stock"
  end

  create_table "sale_details", force: :cascade do |t|
    t.integer "unit"
    t.float "import"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id", null: false
    t.integer "sale_id", null: false
    t.index ["product_id"], name: "index_sale_details_on_product_id"
    t.index ["sale_id"], name: "index_sale_details_on_sale_id"
  end

  create_table "sales", force: :cascade do |t|
    t.datetime "date", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "client_id", null: false
    t.integer "price_list_id", null: false
    t.index ["client_id"], name: "index_sales_on_client_id"
    t.index ["price_list_id"], name: "index_sales_on_price_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "bill_items", "bills"
  add_foreign_key "bill_items", "sale_details"
  add_foreign_key "bills", "sales"
  add_foreign_key "category_products", "categories"
  add_foreign_key "category_products", "products"
  add_foreign_key "sale_details", "products"
  add_foreign_key "sale_details", "sales"
  add_foreign_key "sales", "clients"
  add_foreign_key "sales", "price_lists"
end
