# frozen_string_literal: true

# == Schema Information
#
# Table name: homilists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  photo      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Homilist < ApplicationRecord
  has_many :sermons
  validates :name, presence: true
end
