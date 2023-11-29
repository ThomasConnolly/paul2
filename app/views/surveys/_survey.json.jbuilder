# frozen_string_literal: true

json.extract!(survey, :id, :q1, :q2, :q3, :a1, :a2, :a3, :added_comments, :created_at,
              :updated_at)
json.url(survey_url(survey, format: :json))
