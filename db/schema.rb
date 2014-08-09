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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140808193204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: true do |t|
    t.decimal  "price",        precision: 8, scale: 2
    t.integer  "menu_item_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["menu_item_id"], name: "index_carts_on_menu_item_id", using: :btree
  add_index "carts", ["order_id"], name: "index_carts_on_order_id", using: :btree

  create_table "menu_items", force: true do |t|
    t.text     "name",                                null: false
    t.text     "image_url"
    t.decimal  "price",       precision: 8, scale: 2
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", force: true do |t|
    t.boolean  "is_addon"
    t.integer  "menu_item_id"
    t.integer  "topping_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "options", ["menu_item_id"], name: "index_options_on_menu_item_id", using: :btree
  add_index "options", ["topping_id"], name: "index_options_on_topping_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer "user_id"
    t.decimal "price",        precision: 8, scale: 2
    t.boolean "is_purchased"
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "selections", force: true do |t|
    t.integer  "cart_id"
    t.integer  "option_id"
    t.boolean  "is_selected"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "selections", ["cart_id"], name: "index_selections_on_cart_id", using: :btree
  add_index "selections", ["option_id"], name: "index_selections_on_option_id", using: :btree

  create_table "toppings", force: true do |t|
    t.text     "name",                               null: false
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "username"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
