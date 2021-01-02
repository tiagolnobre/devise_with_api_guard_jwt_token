# frozen_string_literal: true

class ApplicationController < ActionController::API
  # Devise code
  before_action :configure_permitted_parameters, if: :devise_controller?

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :unauthorized

  protected

  # Devise methods
  # Authentication key(:username) and password field will be added automatically by devise.
  def configure_permitted_parameters
    added_attrs = [:email, :first_name, :last_name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
