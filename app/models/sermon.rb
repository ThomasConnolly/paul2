# frozen_string_literal: true

# == Schema Information
#
# Table name: sermons
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  cites        :string(255)
#  sermon_body  :text
#  created_at   :datetime
#  updated_at   :datetime
#  homilist_id  :integer
#  delivered_on :date
#  audio        :string
#

class Sermon < ApplicationRecord
  has_rich_text :content
  belongs_to :homilist
  validates :title, :delivered_on, :homilist_id, presence: true
end
