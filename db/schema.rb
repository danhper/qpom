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

ActiveRecord::Schema.define(:version => 20121210023519) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.integer  "main_category_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "coupon_usages", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "times_used"
    t.integer  "user_id"
    t.integer  "coupon_id"
  end

  create_table "coupons", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.boolean  "sharable"
    t.string   "image"
    t.datetime "validity_start_datetime"
    t.datetime "validity_end_datetime"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "target"
    t.integer  "max_usage"
    t.integer  "shop_id"
    t.integer  "used_times"
    t.integer  "shared_times"
    t.integer  "distributed_times"
    t.boolean  "is_active"
  end

  create_table "genres", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "main_category_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "address"
    t.integer  "prefecture_id"
    t.integer  "town_id"
    t.integer  "area_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "main_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "prefectures", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "area_id"
  end

  create_table "shop_settings", :force => true do |t|
    t.integer  "shop_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shop_users", :id => false, :force => true do |t|
    t.integer "shop_id"
    t.integer "user_id"
  end

  add_index "shop_users", ["shop_id", "user_id"], :name => "index_shop_users_on_shop_id_and_user_id"

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.string   "name_furigana"
    t.string   "phone_number"
    t.string   "representative"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "account_name"
    t.integer  "prefecture_id"
    t.integer  "area_id"
    t.integer  "town_id"
    t.string   "address"
    t.string   "access"
    t.string   "fax"
    t.time     "open_time"
    t.time     "close_time"
    t.string   "description"
  end

  add_index "shops", ["email"], :name => "index_shops_on_email", :unique => true
  add_index "shops", ["reset_password_token"], :name => "index_shops_on_reset_password_token", :unique => true

  create_table "shops_users", :id => false, :force => true do |t|
    t.integer "shop_id"
    t.integer "user_id"
  end

  add_index "shops_users", ["shop_id", "user_id"], :name => "index_shops_users_on_shop_id_and_user_id"

  create_table "stations", :force => true do |t|
    t.string   "name"
    t.integer  "train_line_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "sub_categories", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "towns", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "prefecture_id"
  end

  create_table "train_companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "train_lines", :force => true do |t|
    t.string   "name"
    t.integer  "train_company_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "user_settings", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
