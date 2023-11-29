# frozen_string_literal: true

# == Schema Information
#
# Table name: pray_fors
#
#  id         :bigint           not null, primary key
#  first_name :string
#  reason     :string
#  honey      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PrayFor < ApplicationRecord
  validates :first_name, format: { with: /[a-zA-Z]/ }
  validates :reason, format: { with: /[a-zA-Z]/ }
  # honey used to prevent bots-filled forms from being saved to db
  validates :honey, absence: true
end
