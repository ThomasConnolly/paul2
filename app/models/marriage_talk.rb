# frozen_string_literal: true

# == Schema Information
#
# Table name: marriage_talks
#
#  id           :bigint           not null, primary key
#  title        :string
#  body         :text
#  delivered_on :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class MarriageTalk < ApplicationRecord
end
