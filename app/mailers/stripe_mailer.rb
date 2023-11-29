# frozen_string_literal: true

class StripeMailer < ApplicationMailer
  def report_created(stripe_report)
    @stripe_report = stripe_report
    @url = 'https://www.saintpaulsnaples.org/stripe_reports/stripe_report_id'
    mail(
      to: 'accountant@SaintPaulsNaples.org',
      bcc: 'tom.connolly@comcast.net',
      subject: 'A new activity at Stripe'
    )
  end
end
