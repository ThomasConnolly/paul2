# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  amount     :integer
#  date       :date
#  photo      :string
#  price      :integer
#  quantity   :integer
#  time       :string
#  title      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ApplicationRecord
  has_many :tickets
  # has_attachment :event_picture
  validates :title, presence: true
end
