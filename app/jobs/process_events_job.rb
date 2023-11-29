# frozen_string_literal: true

class ProcessEventsJob < ApplicationJob
  queue_as :default

  def perform(event_id)
    event = WebhookEvent.find(event_id)
    if event.pending? || event.failed?
      event.update(state: :processing)

      Events::StripeHandler.process(event)
      event.update(state: :processed)
      Stripe::WebhookEndpoint.list({ limit: 3 })
    end
  rescue StandardError => e
    event.update(state: :failed, processing_errors: e)
  end
end
