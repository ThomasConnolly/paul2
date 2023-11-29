# frozen_string_literal: true

# == Schema Information
#
# Table name: donations
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  type       :string
#  stripe_id  :string
#  amount     :integer
#  dollars    :integer
#  status     :string
#  memo       :string
#

class Donation < ApplicationRecord
  belongs_to :user
  validates :dollars, presence: { numericality: { only_integer: true } }
  before_save :set_amount
  before_save :set_stripe_id

  def set_amount
    self.amount = dollars.to_i * 100
    amount
  end

  # prod_EP... is for production, Ky for test. Silence one or the other!
  def set_stripe_id
    price = Stripe::Price.create({
                                   unit_amount: amount,
                                   currency: 'usd',
                                   product: 'prod_EP0UOHa0sNeorA'
                                   # product: 'prod_Kyu7StID0XtS7W'

                                 })
    self.stripe_id = price.id
  end
end
