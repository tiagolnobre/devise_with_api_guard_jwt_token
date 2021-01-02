# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        wrap_parameters :user, include: [:email, :password]

        def create
          build_resource(sign_up_params)
          resource.save
          if resource.persisted?
            expire_data_after_sign_in! unless resource.active_for_authentication?

            render json: { result: UserSerializer.new(resource).serializable_hash[:data][:attributes] }
          else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
          end
        end

        private

        def sign_up_params
          params.permit(:email, :password)
        end
      end
    end
  end
end
