# frozen_string_literal: true

class CheckoutTicketsController < ApplicationController
  protect_from_forgery except: :webhook

  def create
    @ticket = Ticket.find(params[:id])

    if @ticket.nil?
      redirect_to(root_path)
      return
    end

    customer = Stripe::Customer.create(email: @ticket.email)
    @ticket.update!(customer_id: customer.id)
    session = Stripe::Checkout::Session.create({
                                                 success_url: "#{checkout_tickets_success_url}?session_id={CHECKOUT_SESSION_ID}",
                                                 cancel_url: events_url,
                                                 payment_method_types: ['card'],
                                                 submit_type: 'pay',
                                                 customer:,
                                                 line_items: [{
                                                   price: @ticket.stripe_id,
                                                   quantity: 1,
                                                   description: @ticket.event.title
                                                 }],
                                                 client_reference_id: "tic#{@ticket.id}",
                                                 mode: 'payment'
                                               })
    redirect_to(session.url, allow_other_host: true)
  end
end
