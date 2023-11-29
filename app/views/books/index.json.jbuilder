# frozen_string_literal: true

json.array!(@books) do |book|
  json.extract!(book, :id, :author, :title, :subject, :isbn, :dewey)
  json.url(book_url(book, format: :json))
end
