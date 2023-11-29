# frozen_string_literal: true

json.array!(@events) do |event|
  json.extract!(event, :id, :title, :price, :date)
  json.url(event_url(event, format: :json))
end
