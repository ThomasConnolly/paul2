# frozen_string_literal: true

json.extract!(pathway, :id, :image, :title, :link, :created_at, :updated_at)
json.url(pathway_url(pathway, format: :json))
