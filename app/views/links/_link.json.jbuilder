# frozen_string_literal: true

json.extract!(link, :id, :event, :time, :date, :url, :created_at, :updated_at)
json.url(link_url(link, format: :json))
