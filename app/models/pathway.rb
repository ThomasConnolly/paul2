# frozen_string_literal: true

# == Schema Information
#
# Table name: pathways
#
#  id         :bigint           not null, primary key
#  image      :string
#  pubdate    :date
#  link       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pathway < ApplicationRecord
  validates :link, presence: true
  validates :image, presence: true
  validates :pubdate, presence: true
end
