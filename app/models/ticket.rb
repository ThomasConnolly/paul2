# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id          :integer          not null, primary key
#  price       :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#  quantity    :integer
#  amount      :integer
#  first_name  :string
#  last_name   :string
#  email       :string
#  customer_id :string
#  checkout    :string
#  honey       :string
#  stripe_id   :string
#

class Ticket < ApplicationRecord
  belongs_to :event
  before_save :set_amount
  before_save :set_stripe_id
  # honey used to prevent bots-filled forms from being saved to db
  validates :honey, absence: true
  validates :quantity, presence: true

  def set_amount
    self.amount = quantity * price
  end

  def set_stripe_id
    price = Stripe::Price.create({
                                   unit_amount: amount,
                                   currency: 'usd',
                                   product: 'prod_LBHbVPOcXJU6lX'
                                 })
    self.stripe_id = price.id
  end
end
