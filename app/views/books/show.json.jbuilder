# frozen_string_literal: true

json.extract!(
  @book,
  :id,
  :author,
  :title,
  :subject,
  :isbn,
  :dewey,
  :created_at,
  :updated_at
)
