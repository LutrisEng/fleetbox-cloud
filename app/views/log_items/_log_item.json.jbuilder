json.extract! log_item, :id, :display_name, :include_time, :performed_at, :created_at, :updated_at
json.url log_item_url(log_item, format: :json)
