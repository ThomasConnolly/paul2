# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :content, presence: true
  validates :user_id, presence: true
  has_rich_text :content
  has_one_attached :picture
  has_many_attached :photos

  default_scope -> { order('created_at DESC') }

  def image_as_thumbnail
    image.variant(resize_to_limit: [350, 350]).processed
  end
end
