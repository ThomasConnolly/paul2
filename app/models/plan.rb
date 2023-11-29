# frozen_string_literal: true

# == Schema Information
#
# Table name: plans
#
#  id             :bigint           not null, primary key
#  amount         :integer
#  interval       :string
#  interval_count :string
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  stripe_id      :string
#
class Plan < ApplicationRecord
end
