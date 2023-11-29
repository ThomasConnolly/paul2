# frozen_string_literal: true

class CheckoutPledgesController < ApplicationController
  protect_from_forgery except: :webhook
  before_action :authenticate_user!

  def create
    @pledge = Pledge.find(params[:id])
    if @pledge.nil?
      redirect_to(root_path)
      return
    end

    @customer = if current_user.stripe_id?
                  Stripe::Customer.retrieve(current_user.stripe_id)
                else
                  Stripe::Customer.create(email: current_user.email)
                end
    current_user.update(stripe_id: @customer.id)

    checkout_session = Stripe::Checkout::Session.create(
      mode: 'payment',
      success_url: "#{checkout_pledges_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: pledges_url,
      line_items: [{
        price: (@pledge.dollars.to_i * 100),
        quantity: 1
      }],
      stripe_customer: @pledge.user.stripe_id,
      metadata: {
        pledge_id: @pledge.id
      }
    )
    redirect_to(checkout_session.url, allow_other_host: true)
  end
end
