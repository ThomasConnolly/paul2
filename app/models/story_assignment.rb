# frozen_string_literal: true

# == Schema Information
#
# Table name: story_assignments
#
#  id            :bigint           not null, primary key
#  story_idea_id :bigint           not null
#  assigned_to   :integer
#  status        :integer          default("pending")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class StoryAssignment < ApplicationRecord
  belongs_to :story_idea, dependent: :destroy
  enum :status, %i[pending submitted]
end
