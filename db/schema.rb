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

ActiveRecord::Schema.define(:version => 20110210211558) do

  create_table "acheivement_earnings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "acheivement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "acheivements", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "requirements_to_earn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", :force => true do |t|
    t.integer  "actor_id",                            :null => false
    t.string   "actor_type",                          :null => false
    t.integer  "target_id",                           :null => false
    t.string   "target_type",                         :null => false
    t.string   "verb"
    t.string   "activity_type"
    t.string   "status",        :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["actor_id", "actor_type"], :name => "fk_actor"
  add_index "activities", ["target_id", "target_type"], :name => "fk_target"

  create_table "answerings", :force => true do |t|
    t.integer  "quizzing_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.text     "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.text     "content"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "title"
    t.integer  "snip_at"
    t.integer  "view_count",       :default => 0
    t.text     "content"
    t.text     "excerpt"
    t.string   "status",           :default => "publish"
    t.boolean  "comments_allowed"
    t.datetime "publish_at"
    t.string   "article_type"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["cached_slug"], :name => "index_articles_on_cached_slug", :unique => true
  add_index "articles", ["owner_id"], :name => "index_articles_on_owner_id"

  create_table "attachments", :force => true do |t|
    t.integer  "owner_id",                              :null => false
    t.string   "owner_type",                            :null => false
    t.string   "attachment_type"
    t.string   "name"
    t.string   "format"
    t.string   "path"
    t.string   "filesize"
    t.string   "origin"
    t.string   "ip"
    t.boolean  "remote",          :default => false
    t.string   "status",          :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["owner_id", "owner_type"], :name => "fk_owner"

  create_table "award_assignments", :force => true do |t|
    t.integer  "award_id"
    t.integer  "user_id"
    t.integer  "creator_id"
    t.integer  "points_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "awards", :force => true do |t|
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "name"
    t.text     "description"
    t.string   "asin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "checkins", :force => true do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "objective_assignment_id"
    t.string   "status",                  :default => "did_not"
    t.integer  "confirmed_by"
    t.datetime "confirmed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "reply_to_comment_id"
    t.string   "ip"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["reply_to_comment_id"], :name => "index_comments_on_reply_to_comment_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "contacts", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.string   "subject"
    t.string   "ip"
    t.integer  "crash_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["crash_id"], :name => "index_contacts_on_crash_id"

  create_table "crashes", :force => true do |t|
    t.integer  "site_id"
    t.string   "message"
    t.string   "requested_url"
    t.string   "referrer"
    t.text     "backtrace"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crashes", ["site_id"], :name => "index_crashes_on_site_id"

  create_table "facebook_accounts", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "name"
    t.string   "fb_id"
    t.string   "fb_token"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facebook_accounts", ["owner_id"], :name => "index_facebook_accounts_on_owner_id"

  create_table "follows", :force => true do |t|
    t.integer  "followed_id",                         :null => false
    t.string   "followed_type",                       :null => false
    t.integer  "follower_id",                         :null => false
    t.string   "follower_type",                       :null => false
    t.string   "status",        :default => "active"
    t.string   "follow_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followed_id", "followed_type"], :name => "fk_followed"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "forums", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "title"
    t.string   "availability"
    t.string   "description"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forums", ["cached_slug"], :name => "index_forums_on_cached_slug", :unique => true
  add_index "forums", ["owner_id"], :name => "index_forums_on_owner_id"

  create_table "note_deliveries", :force => true do |t|
    t.integer  "note_id"
    t.integer  "recipient_id"
    t.boolean  "unread",       :default => true
    t.string   "status",       :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "sender_id"
    t.string   "font",             :default => "schoolbell"
    t.string   "font_color",       :default => "#333"
    t.string   "background_color", :default => "#ffd"
    t.string   "subject"
    t.text     "content"
    t.integer  "points",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "objective_assignments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "objective_id"
    t.integer  "creator_id"
    t.integer  "times"
    t.datetime "due_at"
    t.string   "period"
    t.boolean  "req_checkin",  :default => true
    t.boolean  "req_confirm",  :default => false
    t.integer  "points_value", :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "objectives", :force => true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ownings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ownable_id"
    t.string   "ownable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "point_earnings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "earned_for_id"
    t.string   "earned_for_type"
    t.integer  "points_earned"
    t.string   "earning_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "point_spendings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "owning_id"
    t.integer  "points_spent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "topic_id"
    t.integer  "reply_to_post_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.integer  "view_count",       :default => 0
    t.string   "ip"
    t.string   "type"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["cached_slug"], :name => "index_posts_on_cached_slug", :unique => true
  add_index "posts", ["forum_id"], :name => "index_posts_on_forum_id"
  add_index "posts", ["reply_to_post_id"], :name => "index_posts_on_reply_to_post_id"
  add_index "posts", ["topic_id"], :name => "index_posts_on_topic_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "questions", :force => true do |t|
    t.integer  "quiz_id"
    t.text     "content"
    t.string   "extra_content"
    t.integer  "points",        :default => 0
    t.integer  "seq"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", :force => true do |t|
    t.string   "name"
    t.integer  "created_by_id"
    t.text     "description"
    t.integer  "points",        :default => 0
    t.integer  "level"
    t.string   "quiz_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzings", :force => true do |t|
    t.integer  "quiz_id"
    t.integer  "user_id"
    t.integer  "question_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raw_stats", :force => true do |t|
    t.integer  "statable_id"
    t.string   "statable_type"
    t.string   "name"
    t.string   "ip"
    t.integer  "count",         :default => 0
    t.string   "extra_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raw_stats", ["statable_id"], :name => "index_raw_stats_on_statable_id"

  create_table "relations", :force => true do |t|
    t.integer  "child_id"
    t.integer  "user_id"
    t.string   "role"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relations", ["child_id"], :name => "index_relations_on_child_id"
  add_index "relations", ["user_id"], :name => "index_relations_on_user_id"

  create_table "relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "related_user_id"
    t.string   "nickname"
    t.string   "role"
    t.string   "status",          :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "status",     :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["domain"], :name => "index_sites_on_domain"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "static_pages", :force => true do |t|
    t.integer  "site_id"
    t.string   "title"
    t.string   "description"
    t.string   "permalink"
    t.string   "redirect_path"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "static_pages", ["permalink"], :name => "index_static_pages_on_permalink"
  add_index "static_pages", ["site_id"], :name => "index_static_pages_on_site_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "twitter_accounts", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "twit_id"
    t.string   "token"
    t.string   "secret"
    t.string   "name"
    t.string   "status",     :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "twitter_accounts", ["owner_id"], :name => "index_twitter_accounts_on_owner_id"

  create_table "unlockables", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "points_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "type"
    t.integer  "site_id"
    t.integer  "registered_by_id"
    t.string   "email"
    t.string   "name"
    t.string   "display_name"
    t.integer  "score",                     :default => 0
    t.datetime "birthday"
    t.string   "gender"
    t.integer  "points_earned",             :default => 0
    t.integer  "points_balance",            :default => 0
    t.integer  "level",                     :default => 0
    t.string   "website_name"
    t.string   "website_url"
    t.text     "bio"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code"
    t.datetime "activated_at"
    t.string   "invitation_code"
    t.string   "status",                    :default => "first"
    t.string   "cached_slug"
    t.string   "orig_ip"
    t.string   "last_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["activation_code"], :name => "index_users_on_activation_code"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

  create_table "wishlist_items", :force => true do |t|
    t.integer  "wishlist_id"
    t.string   "name"
    t.string   "description"
    t.string   "asin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wishlist_items", ["wishlist_id"], :name => "index_wishlist_items_on_wishlist_id"

  create_table "wishlists", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "status",      :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
