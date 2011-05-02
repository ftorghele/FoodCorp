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

ActiveRecord::Schema.define(:version => 20110428120416) do

  create_table "fellowships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meal_arrangements", :force => true do |t|
    t.integer  "meal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "acceptance"
  end

  create_table "meals", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "time"
    t.integer  "deadline"
    t.float    "lat"
    t.float    "lon"
    t.string   "country"
    t.string   "city"
    t.string   "zip_code"
    t.string   "street"
    t.string   "street_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "slots"
  end

  create_table "messages", :force => true do |t|
    t.string  "topic"
    t.text    "body"
    t.integer "received_messageable_id"
    t.string  "received_messageable_type"
    t.integer "sent_messageable_id"
    t.string  "sent_messageable_type"
    t.boolean "opened",                    :default => false
    t.boolean "recipient_delete",          :default => false
    t.boolean "sender_delete",             :default => false
  end

  add_index "messages", ["sent_messageable_id", "received_messageable_id"], :name => "acts_as_messageable_ids"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.string   "birthday"
    t.integer  "fb_id"
    t.string   "country"
    t.string   "city"
    t.string   "zip_code"
    t.string   "street"
    t.string   "street_number"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "use_fb_avatar"
    t.integer  "points",                              :default => 0
    t.text     "info_field"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
