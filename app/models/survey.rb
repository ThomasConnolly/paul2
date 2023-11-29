# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id             :bigint           not null, primary key
#  user_id        :integer
#  q1             :string
#  q2             :string
#  q3             :string
#  a1             :text
#  a2             :text
#  a3             :text
#  added_comments :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Survey < ApplicationRecord
  belongs_to :user
end
