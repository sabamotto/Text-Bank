json.extract! attachment, :id, :name, :mime, :data, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
