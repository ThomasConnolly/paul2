# frozen_string_literal: true

# == Schema Information
#
# Table name: stories
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  user_id    :bigint           not null
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Story < ApplicationRecord
  belongs_to :user
  has_rich_text :body
end
