# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < Devise::ConfirmationsController
        def show
          self.resource = resource_class.confirm_by_token(params[:confirmation_token])
          yield resource if block_given?

          if resource.errors.empty?
            respond_with(resource)
          else
            unprocessable_entity(resource.errors)
          end
        end

        private

        def respond_with(resource, _opts = {})
          render json: { result: UserSerializer.new(resource).serializable_hash[:data][:attributes] }
        end

        def respond_to_on_destroy
          head :ok
        end
      end
    end
  end
end
