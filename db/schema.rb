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

ActiveRecord::Schema.define(:version => 20120614132400) do

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id",   :default => 0
    t.string   "commentable_type", :default => ""
    t.string   "title",            :default => ""
    t.text     "body"
    t.string   "subject",          :default => ""
    t.integer  "user_id",          :default => 0,  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["parent_id"], :name => "index_comments_on_parent_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "current_user_locations", :force => true do |t|
    t.integer  "user_id"
    t.string   "street"
    t.integer  "street_number"
    t.integer  "zip_code"
    t.string   "city"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "activate",      :default => true
    t.text     "country"
  end

  create_table "fellowships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "follower_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fellowships", ["follower_id"], :name => "index_fellowships_on_follower_id"
  add_index "fellowships", ["user_id"], :name => "index_fellowships_on_user_id"

  create_table "meal_arrangements", :force => true do |t|
    t.integer  "meal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "acceptance"
  end

  add_index "meal_arrangements", ["meal_id"], :name => "index_meal_arrangements_on_meal_id"
  add_index "meal_arrangements", ["user_id"], :name => "index_meal_arrangements_on_user_id"

  create_table "meals", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
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
    t.boolean  "vegetarien",    :default => false
    t.boolean  "organic",       :default => false
    t.boolean  "kosher",        :default => false
    t.boolean  "halal",         :default => false
    t.boolean  "lactose_free",  :default => false
    t.boolean  "gluten_free",   :default => false
    t.boolean  "diabetics",     :default => false
    t.boolean  "hot",           :default => false
    t.boolean  "veryhot",       :default => false
    t.boolean  "asian",         :default => false
    t.boolean  "eat_in",        :default => false
    t.boolean  "take_away",     :default => false
    t.boolean  "got_point",     :default => false
    t.date     "time"
    t.date     "deadline"
    t.datetime "times"
    t.datetime "deadline_time"
  end

  add_index "meals", ["user_id"], :name => "index_meals_on_user_id"

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

  create_table "users", :force => true do |t|
    t.string   "email",                                   :default => "",    :null => false
    t.string   "encrypted_password",       :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                           :default => 0
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
    t.string   "room_number"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "use_fb_avatar"
    t.integer  "points",                                  :default => 1
    t.text     "info_field"
    t.boolean  "mail_notification",                       :default => false
    t.text     "email_adresse"
    t.boolean  "got_invitation",                          :default => false
    t.integer  "current_user_location_id",                :default => 0
    t.integer  "meal_counter",                            :default => 0
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["fb_id"], :name => "index_users_on_fb_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
