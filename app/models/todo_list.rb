# frozen_string_literal: true

# == Schema Information
#
# Table name: todo_lists
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TodoList < ApplicationRecord
  belongs_to :user
  has_many :todo_items

  accepts_nested_attributes_for :todo_items
end
