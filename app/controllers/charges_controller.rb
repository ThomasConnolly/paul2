# frozen_string_literal: true

class ChargesController < ApplicationController
  # use to checkout ticket purchases

  def new; end

  def create
    @ticket = Ticket.find(params[:ticket_id])
  end
end
