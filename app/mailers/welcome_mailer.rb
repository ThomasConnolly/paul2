# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(
      to: @user.email,
      bcc: 'tom.connolly@comcast.net',
      subject: "Welcome to Saint Paul's website"
    )
  end
end
