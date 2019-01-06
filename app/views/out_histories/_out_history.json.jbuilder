json.extract! out_history, :id, :rec_time, :site_id, :article_id, :ip, :chkd, :created_at, :updated_at
json.url out_history_url(out_history, format: :json)
