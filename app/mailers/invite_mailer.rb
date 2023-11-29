# frozen_string_literal: true

class InviteMailer < Devise::Mailer
  default to: proc { Member.pluck(:email, :first_name, :last_name) }

  def invitation_instructions
    @token = token
    devise_mail(record, record.invitation_instructions || :invitation_instructions, opts)
  end
end
