# frozen_string_literal: true

class VnoteMailer < ApplicationMailer
  def vnote_created(vnote)
    @vnote = vnote
    @url = url_for(@vnote)
    mail(
      to: User.where('? = ANY(roles)', 'vestry').pluck(:email),
      subject: "There's a new topic on the vestry forum."
    )
  end
end
