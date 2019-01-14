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

ActiveRecord::Schema.define(version: 2019_01_05_085400) do

  create_table "article_out_counts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "last_time", null: false
    t.integer "article_id", null: false
    t.integer "count", default: 0, null: false
    t.integer "week_count", default: 0, null: false
    t.index ["article_id"], name: "index_article_out_counts_on_article_id"
    t.index ["count"], name: "index_article_out_counts_on_count"
    t.index ["last_time"], name: "index_article_out_counts_on_last_time"
  end

  create_table "articles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "site_id", null: false
    t.datetime "post_time"
    t.string "name", null: false
    t.string "url", limit: 2047
    t.datetime "pull_time", null: false
    t.string "chkd"
    t.index ["category_id", "post_time"], name: "index_articles_on_category_id_and_post_time"
    t.index ["category_id", "site_id", "post_time"], name: "index_articles_on_category_id_and_site_id_and_post_time"
    t.index ["chkd"], name: "index_articles_on_chkd", unique: true
    t.index ["post_time"], name: "index_articles_on_post_time"
  end

  create_table "categories", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "icon_url", limit: 2047
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "check_cookies", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "hash", null: false
    t.datetime "last_time", null: false
    t.index ["hash"], name: "index_check_cookies_on_hash", unique: true
  end

  create_table "check_ips", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "ip", null: false
    t.datetime "last_time", null: false
    t.index ["ip"], name: "index_check_ips_on_ip", unique: true
  end

  create_table "daily_in_counts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "count_date", null: false
    t.integer "site_id", null: false
    t.integer "count", default: 0, null: false
    t.index ["count_date", "count"], name: "index_daily_in_counts_on_count_date_and_count"
  end

  create_table "daily_out_counts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "count_date", null: false
    t.integer "site_id", null: false
    t.integer "count", default: 0, null: false
    t.integer "week_count", default: 0, null: false
    t.index ["count_date", "count"], name: "index_daily_out_counts_on_count_date_and_count"
  end

  create_table "sites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "category_id", null: false
    t.string "name", null: false
    t.string "url", limit: 2047
    t.string "feed_url", limit: 2047
    t.string "thumbnail_url", limit: 2047
    t.string "icon_url", limit: 2047
    t.datetime "last_post_time"
    t.string "match_in_url"
    t.integer "week_in_count", default: 0, null: false
    t.integer "week_out_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sites_on_category_id"
    t.index ["match_in_url"], name: "index_sites_on_match_in_url", unique: true
  end

end
