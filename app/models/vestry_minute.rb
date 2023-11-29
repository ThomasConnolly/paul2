# frozen_string_literal: true

# == Schema Information
#
# Table name: vestry_minutes
#
#  id         :integer          not null, primary key
#  date       :date
#  minutes    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  draft      :boolean
#

class VestryMinute < ApplicationRecord
  has_rich_text :body
  default_scope -> { order('created_at DESC') }
  validates :date, presence: true
  validates :body, presence: true
  validates :draft, inclusion: { in: [true, false] }
end
