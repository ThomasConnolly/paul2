# frozen_string_literal: true

# == Schema Information
#
# Table name: meditations
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  scripture  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  prayer     :string
#  publish_on :date
#  honey      :string
#

class Meditation < ApplicationRecord
  validates :name, :title, :scripture, :prayer, :body, presence: true

  # honey used to prevent bots-filled forms from being saved to db
  validates :honey, absence: true

  default_scope -> { order('publish_on ASC') }
end
