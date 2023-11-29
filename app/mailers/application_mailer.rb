# frozen_string_literal: true

# example send email to all members from cli:
# MemberMailer.member_work(@member).deliver_now
# or
# MemberMailer.member_survey(@member).deliver_now
# That's it!

class ApplicationMailer < ActionMailer::Base
  default from: 'webmaster@saintpaulsnaples.org'
  layout 'mailer'
end
