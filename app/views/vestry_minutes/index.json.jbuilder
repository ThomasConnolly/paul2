# frozen_string_literal: true

json.array!(@vestry_minutes) do |vestry_minute|
  json.extract!(vestry_minute, :id, :date, :minutes)
  json.url(vestry_minute_url(vestry_minute, format: :json))
end
