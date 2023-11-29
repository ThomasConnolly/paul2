# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_rooms_on_name  (name) UNIQUE
#

class Room < ApplicationRecord
  has_many :messages
end
