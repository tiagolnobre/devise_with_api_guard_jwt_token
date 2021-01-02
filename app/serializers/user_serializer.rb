# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at, :confirmation_sent_at, :confirmed_at

  def confirmed
    !confirmed_at.nil?
  end
end
