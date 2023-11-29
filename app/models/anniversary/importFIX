# frozen_string_literal: true

module Anniversary
  class Import
    include ActiveModel::Model
    attr_accessor :file, :imported_count

    def process!
      @imported_count = 0
      CSV.foreach(file.path, headers: true, header_converters: :symbol) do |row|
        anniversary = Anniversary.assign_from_row(row)
        if anniversary.save
          @imported_count += 1
        else
          errors.add :base, "Line #{$INPUT_LINE_NUMBER} - #{anniversary.errors
        .full_messages.join(',')}"
        end
      end
    end

    def save
      process!
      errors.none?
    end
  end
end
