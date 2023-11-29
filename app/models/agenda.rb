# frozen_string_literal: true

# == Schema Information
#
# Table name: agendas
#
#  id           :bigint           not null, primary key
#  meeting_date :date
#  user_id      :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  draft        :boolean
#
class Agenda < ApplicationRecord
  has_many :agenda_items, inverse_of: :agenda, dependent: :destroy
  accepts_nested_attributes_for :agenda_items, allow_destroy: true,
                                               reject_if: :all_blank
  belongs_to :user
  validates :meeting_date, presence: true
  validates :draft, inclusion: { in: [true, false] }
end
