# encoding: UTF-8
# frozen_string_literal: true

=begin
rails generate scaffold category ^
  name:string
rails generate scaffold site ^
  category_id:integer name:string url:string feed_url:string 
rails generate scaffold article ^
  site_id:integer post_time:datetime name:string url:string ^
  pull_time:datetime chkd:string 
rails generate scaffold in_histories ^
  rec_time:datetime site_id:integer referer:string ^
  ip:string chkd:string request_line:string
rails generate scaffold out_histories ^
  rec_time:datetime site_id:integer article_id:integer ^
  ip:string chkd:string
rails generate scaffold daily_in_counts ^
  count_date:integer site_id:integer count:integer
rails generate scaffold daily_out_counts ^
  count_date:integer site_id:integer count:integer
rails generate scaffold article_out_count ^
  last_time:datetime article_id:integer count:integer
=end

class InitSchema < ActiveRecord::Migration[4.2]
    def up
      create_table "categories", force: :cascade do |t|
        t.string   "name", limit: 255, null: false
        t.string   "icon_url", limit: 2047
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
      end
      create_table "sites", force: :cascade do |t|
        t.integer  "category_id", limit: 4, null: false
        t.string   "name", limit: 255, null: false
        t.string   "url", limit: 2047
        t.string   "feed_url", limit: 2047
        t.string   "thumbnail_url", limit: 2047
        t.string   "icon_url", limit: 2047
        t.datetime "last_post_time"
        t.string   "match_in_url", limit: 255
        t.integer  "week_in_count", limit: 4, null: false, default: 0
        t.integer  "week_out_count", limit: 4, null: false, default: 0
        t.datetime "created_at", null: false
        t.datetime "updated_at", null: false
      end
      add_index "sites", ["category_id"], name: "index_sites_on_category_id", using: :btree
      add_index "sites", ["match_in_url"], name: "index_sites_on_match_in_url", unique: true, using: :btree
      create_table "articles", force: :cascade do |t|
        t.integer  "category_id", limit: 4, null: false
        t.integer  "site_id", limit: 4, null: false
        t.datetime "post_time"
        t.string   "name", limit: 255, null: false
        t.string   "url", limit: 2047
        t.datetime "pull_time", null: false
        t.string   "chkd", limit: 255
      end
      add_index "articles", ["post_time"], name: "index_articles_on_post_time", using: :btree
      add_index "articles", ["category_id","site_id","post_time"], name: "index_articles_on_category_id_and_site_id_and_post_time", using: :btree
      add_index "articles", ["category_id","post_time"], name: "index_articles_on_category_id_and_post_time", using: :btree
      add_index "articles", ["chkd"], name: "index_articles_on_chkd", unique: true, using: :btree
      create_table "daily_in_counts", force: :cascade do |t|
        t.integer  "count_date", limit: 4, null: false
        t.integer  "site_id", limit: 4, null: false
        t.integer  "count", limit: 4, null: false, default: 0
      end
      add_index "daily_in_counts", ["count_date","count"], name: "index_daily_in_counts_on_count_date_and_count", using: :btree
      create_table "daily_out_counts", force: :cascade do |t|
        t.integer  "count_date", limit: 4, null: false
        t.integer  "site_id", limit: 4, null: false
        t.integer  "count", limit: 4, null: false, default: 0
        t.integer  "week_count", limit: 4, null: false, default: 0
      end
      add_index "daily_out_counts", ["count_date","count"], name: "index_daily_out_counts_on_count_date_and_count", using: :btree
      create_table "article_out_counts", force: :cascade do |t|
        t.datetime "last_time", null: false
        t.integer  "article_id", limit: 4, null: false
        t.integer  "count", limit: 4, null: false, default: 0
        t.integer  "week_count", limit: 4, null: false, default: 0
      end
      add_index "article_out_counts", ["article_id"], name: "index_article_out_counts_on_article_id", using: :btree
      add_index "article_out_counts", ["last_time"], name: "index_article_out_counts_on_last_time", using: :btree
      add_index "article_out_counts", ["count"], name: "index_article_out_counts_on_count", using: :btree
      create_table "check_ips", force: :cascade do |t|
        t.string   "ip", limit: 255, null: false
        t.datetime "last_time", null: false
      end
      add_index "check_ips", ["ip"], name: "index_check_ips_on_ip", unique: true, using: :btree
      create_table "check_cookies", force: :cascade do |t|
        t.string   "hash", limit: 255, null: false
        t.datetime "last_time", null: false
      end
      add_index "check_cookies", ["hash"], name: "index_check_cookies_on_hash", unique: true, using: :btree
    end

    def down
      raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
    end
  end