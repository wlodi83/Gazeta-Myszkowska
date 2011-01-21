# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 32) do

  create_table "advert_modules", :force => true do |t|
    t.string   "name",       :limit => 200, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advertisements", :force => true do |t|
    t.string   "name",       :limit => 200,                                                  :null => false
    t.integer  "height"
    t.integer  "width"
    t.string   "page",       :limit => 100,                                                  :null => false
    t.boolean  "color",                                                   :default => false
    t.decimal  "price",                     :precision => 8, :scale => 2,                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "synopsis"
    t.text     "body",           :limit => 2147483647,                    :null => false
    t.boolean  "published",                            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.integer  "category_id",                          :default => 1
    t.integer  "comments_count"
  end

  add_index "articles", ["published"], :name => "i_articles_published"

  create_table "attachments", :force => true do |t|
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "parent_id"
    t.integer  "attachable_id"
    t.integer  "position"
    t.string   "content_type",    :limit => 100
    t.string   "filename"
    t.string   "path"
    t.string   "thumbnail"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["parent_id"], :name => "index_attachments_on_parent_id"
  add_index "attachments", ["attachable_id", "attachable_type"], :name => "index_attachments_on_attachable_id_and_attachable_type"

  create_table "categories", :force => true do |t|
    t.string  "name"
    t.integer "parent_id"
  end

  create_table "comments", :force => true do |t|
    t.integer  "entry_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.integer  "article_id"
    t.boolean  "published",  :default => false
  end

  add_index "comments", ["entry_id"], :name => "index_comments_on_entry_id"

  create_table "db_files", :force => true do |t|
    t.binary "data", :limit => 2147483647, :null => false
  end

  create_table "emails", :force => true do |t|
    t.string  "from"
    t.string  "to"
    t.integer "last_send_attempt", :default => 0
    t.text    "mail"
  end

  create_table "entries", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.integer  "comments_count", :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "forums", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count", :default => 0, :null => false
  end

  create_table "homepage_observers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homepages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "models", :force => true do |t|
    t.string  "content_type", :null => false
    t.string  "filename",     :null => false
    t.integer "size",         :null => false
    t.integer "db_file_id"
  end

  create_table "newsletters", :force => true do |t|
    t.string   "subject"
    t.text     "body"
    t.boolean  "sent",       :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newspapers", :force => true do |t|
    t.string "name"
    t.string "street"
    t.string "number"
    t.string "city"
    t.float  "latitude"
    t.float  "longitude"
    t.float  "zoom"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"

  create_table "prints", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_file_size"
    t.string   "image_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id", :null => false
    t.integer "user_id", :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count", :default => 0, :null => false
  end

  add_index "topics", ["forum_id"], :name => "index_topics_on_forum_id"

  create_table "users", :force => true do |t|
    t.string   "username",        :limit => 64,                    :null => false
    t.string   "email",           :limit => 128,                   :null => false
    t.string   "hashed_password", :limit => 64
    t.boolean  "enabled",                        :default => true, :null => false
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_login_at"
    t.integer  "posts_count",                    :default => 0,    :null => false
    t.integer  "entries_count",                  :default => 0,    :null => false
    t.string   "blog_title"
    t.boolean  "enable_comments",                :default => true
    t.integer  "comments_count"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "videos", :force => true do |t|
    t.string   "original_file_name"
    t.string   "original_file_size"
    t.string   "original_content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
