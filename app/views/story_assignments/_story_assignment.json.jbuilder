# frozen_string_literal: true

json.extract!(story_assignment, :id, :story_idea_id, :assigned_to, :status, :created_at,
              :updated_at)
json.url(story_assignment_url(story_assignment, format: :json))
