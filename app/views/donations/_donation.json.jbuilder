# frozen_string_literal: true

json.extract!(donation, :id, :user, :amount, :type, :stripe_email, :stripe_plan,
              :created_at, :updated_at)
json.url(donation_url(donation, format: :json))
