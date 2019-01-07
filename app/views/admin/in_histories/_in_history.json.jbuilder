json.extract! in_history, :id, :rec_time, :site_id, :referer, :ip, :chkd, :request_line, :created_at, :updated_at
json.url in_history_url(in_history, format: :json)
