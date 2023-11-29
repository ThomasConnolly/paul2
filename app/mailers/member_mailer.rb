# frozen_string_literal: true

# instructions on sending the email for surveys:
# launch rails console

# MemberMailer.member_survey(@member).deliver_now
# That's it!

class MemberMailer < ApplicationMailer
  default from: 'Welcome@saintpaulsnaples.org'
  default to: Member.where.not(email: nil).pluck(:email)
end
