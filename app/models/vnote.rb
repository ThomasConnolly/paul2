# frozen_string_literal: true

# == Schema Information
#
# Table name: vnotes
#
#  id         :bigint           not null, primary key
#  title      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Vnote < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, presence: true
  default_scope -> { order('created_at DESC') }
  has_rich_text :content
end
