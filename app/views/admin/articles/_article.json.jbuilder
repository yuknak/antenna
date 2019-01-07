json.extract! article, :id, :site_id, :post_time, :name, :url, :pull_time, :chkd, :created_at, :updated_at
json.url article_url(article, format: :json)
