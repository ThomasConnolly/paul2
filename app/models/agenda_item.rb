# frozen_string_literal: true

# == Schema Information
#
# Table name: agenda_items
#
#  id         :bigint           not null, primary key
#  agenda_id  :bigint           not null
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  position   :integer
#

class AgendaItem < ApplicationRecord
  belongs_to :agenda
  acts_as_list scope: :agenda
  has_rich_text(:details)
  validates :title, presence: true
end

