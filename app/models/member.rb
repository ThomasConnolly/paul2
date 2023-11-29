# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id            :integer          not null, primary key
#  away_zip      :string
#  birthday      :date
#  email         :string
#  first_name    :string
#  last_name     :string
#  username      :string
#  yday          :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  membership_id :string
#

class Member < ApplicationRecord
  acts_as_birthday :birthday
  before_save :set_username
  before_save :set_yday

  require 'date'

  def set_username
    self.username = "#{first_name} #{last_name}".strip
  end

  def set_yday
    self.yday = birthday.yday unless birthday.nil?
  end

  def formatted_email
    "#{username} <#{email}>".strip
  end
end
