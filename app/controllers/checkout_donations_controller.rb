# frozen_string_literal: true

class CheckoutDonationsController < ApplicationController
  protect_from_forgery except: :webhook
  before_action :authenticate_user!

  def create
    @donation = Donation.find(params[:id])
    redirect_to(root_path) if @donation.nil?
    return

    checkout_session = Stripe::Checkout::Session.create(
      { success_url: 'checkout_donations_success_url?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: donations_url, payment_method_types: ['card'],
        submit_type: 'donate',
        customer: @donation.user.stripe_id,
        line_items: [
          { price: @donation.stripe_id,
            quantity: 1,
            description: "Donation to St. Paul's" }
        ],
        metadata: {
          donation_id: @donation.id
        },
        payment_intent_data:
          {
            metadata:
            { donation_id: @donation.id }
          },
        mode: 'payment' }
    )
    redirect_to(checkout_session.url, allow_other_host: true)
  end
end
