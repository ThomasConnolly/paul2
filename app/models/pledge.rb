# frozen_string_literal: true

# == Schema Information
#
# Table name: pledges
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  created_at      :datetime
#  updated_at      :datetime
#  amount          :integer
#  plan            :string
#  subscription_id :string
#  plan_id         :string           default("prod_ETteQ8s9Ho9sNW")
#  status          :string
#  dollars         :integer
#

class Pledge < ApplicationRecord
  belongs_to :user
  validates :dollars, presence: { numericality: { only_integer: true } }
  validates :plan_id, presence: true
  before_save :set_plan_id
  before_destroy :cancel_stripe_subscription, if: :stripe_id

  def set_plan_id
    if Rails.env.production?
      self.plan_id = 'plan_HGF5TFwu6CExEc' if plan == 'quarterly'
      self.plan_id = 'plan_HGF3HFRRZXQ1vS' if plan == 'monthly'
      self.plan_id = 'plan_HGF4nSEWQx4NPv' if plan == 'weekly'
    elsif Rails.env.development?
      self.plan_id = 'prod_KjCI6kAil750Qe' if plan == 'quarterly'
      self.plan_id = 'prod_KjCHYvpdBzTilz' if plan == 'monthly'
      self.plan_id = 'prod_KjCFArWfGU2HFW' if plan == 'weekly'
    end
  end

  def cancel_stripe_subscription
    Stripe::Subscription.retrieve(stripe_id).delete
    self.stripe_id = 'canceled'
  end
end
