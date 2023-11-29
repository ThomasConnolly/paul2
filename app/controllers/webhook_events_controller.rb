# frozen_string_literal: true

class WebhookEventsController < ApplicationController
  # ignore csrf
  skip_forgery_protection

  def create
    unless valid_signatures?
      render(json: { message: 'signature invalid' }, status: :bad_request)
      return
    end
    # idempotent
    unless WebhookEvent.find_by(source: params[:source], external_id:).nil?
      render(json: { message: "Already procesed #{external_id}" })
      return
    end

    event = WebhookEvent.create!(webhook_params)
    ProcessEventsJob.perform_later(event.id)
    render(json: params)
    head(:ok)
  end

  def valid_signatures?
    wh_secret = Rails.application.credentials.dig(:stripe, :signing_secret)
    Stripe::Webhook.construct_event(
      request.body.read,
      request.env['HTTP_STRIPE_SIGNATURE'],
      wh_secret
    )
  rescue Stripe::SignatureVerificationError
    false
  end
  true
end

def external_id
  return params[:id]
  SecureRandom.hex
end

def webhook_params
  {
    data: params.except(:controller, :action).permit!,
    external_id:
  }
end
