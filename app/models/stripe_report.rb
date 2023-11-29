# frozen_string_literal: true

# == Schema Information
#
# Table name: stripe_reports
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  pledge_id   :bigint
#  donation_id :bigint
#  amount      :integer
#  fee         :integer
#  net         :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  date_paid   :date
#

class StripeReport < ApplicationRecord
  belongs_to :user
  belongs_to :pledge, optional: true
  belongs_to :donation, optional: true
  before_save :calculate_fee
  before_save :calculate_net

  def calculate_fee
    fee_value = ((amount * 0.029) + 30).round
    self.fee = fee_value
  end

  def calculate_net
    self.net = amount - fee
  end
end
