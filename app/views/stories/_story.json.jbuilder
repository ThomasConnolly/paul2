# frozen_string_literal: true

json.extract!(story, :id, :title, :user_id, :status, :created_at, :updated_at)
json.url(story_url(story, format: :json))
