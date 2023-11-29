# frozen_string_literal: true

json.extract!(marriage_talk, :id, :title, :body, :delivered_on, :created_at, :updated_at)
json.url(marriage_talk_url(marriage_talk, format: :json))
