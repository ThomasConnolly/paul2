# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  def respond_to_on_destroy
    respond_to do |f|
      f.all { head(:no_content) }
      f.any(*navigational_formats) do
        redirect_to(after_sign_out_path_for(resource_name), status: :see_other)
      end
    end
  end
end
