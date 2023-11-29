# frozen_string_literal: true

class TicketMailer < ApplicationMailer
  def thanks(ticket)
    @ticket = ticket
    mail(to: ticket.email, subject: 'Thank you')
  end
end
