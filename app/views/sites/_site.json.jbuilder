json.extract! site, :id, :category_id, :name, :url, :seed_url, :created_at, :updated_at
json.url site_url(site, format: :json)
