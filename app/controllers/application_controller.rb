# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :store_current_location, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = %i[first_name last_name username email password password_confirmation
                     remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[login password])
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end

  private

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_out_path_for(_resource)
    request.referer || root_path
  end
end
