# frozen_string_literal: true

# == Schema Information
#
# Table name: todo_items
#
#  id           :bigint           not null, primary key
#  description  :text
#  completed    :boolean
#  completed_at :datetime
#  todo_list_id :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  position     :integer
#

class TodoItem < ApplicationRecord
  belongs_to :todo_list, dependent: :destroy
  acts_as_list
end
