# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_and_set_user

      def show
        render json: { result: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
      end
    end
  end
end
