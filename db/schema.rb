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

  create_table "article_out_counts", force: :cascade do |t|
    t.datetime "last_time", null: false
    t.integer "article_id", limit: 4, null: false
    t.integer "count", limit: 4, default: 0, null: false
    t.index ["article_id"], name: "index_article_out_counts_on_article_id"
  end

  create_table "articles", force: :cascade do |t|
    t.integer "site_id", limit: 4, null: false
    t.datetime "post_time"
    t.string "name", limit: 255, null: false
    t.string "url", limit: 65535
    t.datetime "pull_time", null: false
    t.string "chkd", limit: 255
    t.index ["chkd"], name: "index_articles_on_chkd", unique: true
    t.index ["site_id", "post_time"], name: "index_articles_on_site_id_and_post_time"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "icon_url", limit: 65535
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daily_in_counts", force: :cascade do |t|
    t.integer "count_date", limit: 4, null: false
    t.integer "site_id", limit: 4, null: false
    t.integer "count", limit: 4, default: 0, null: false
    t.index ["count_date"], name: "index_daily_in_counts_on_count_date"
  end

  create_table "daily_out_counts", force: :cascade do |t|
    t.integer "count_date", limit: 4, null: false
    t.integer "site_id", limit: 4, null: false
    t.integer "count", limit: 4, default: 0, null: false
    t.index ["count_date"], name: "index_daily_out_counts_on_count_date"
  end

  create_table "in_histories", force: :cascade do |t|
    t.datetime "rec_time", null: false
    t.integer "site_id", limit: 4, null: false
    t.string "referer", limit: 65535
    t.string "ip", limit: 255
    t.string "chkd", limit: 255
    t.string "request_line", limit: 65535
    t.index ["site_id", "rec_time"], name: "index_in_histories_on_site_id_and_rec_time"
  end

  create_table "out_histories", force: :cascade do |t|
    t.datetime "rec_time", null: false
    t.integer "site_id", limit: 4, null: false
    t.integer "article_id", limit: 4
    t.string "ip", limit: 255
    t.string "chkd", limit: 255
    t.index ["site_id", "rec_time"], name: "index_out_histories_on_site_id_and_rec_time"
  end

  create_table "sites", force: :cascade do |t|
    t.integer "category_id", limit: 4, null: false
    t.string "name", limit: 255, null: false
    t.string "url", limit: 65535
    t.string "feed_url", limit: 65535
    t.string "thumbnail_url", limit: 65535
    t.string "icon_url", limit: 65535
    t.datetime "last_post_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_sites_on_category_id"
  end

end
