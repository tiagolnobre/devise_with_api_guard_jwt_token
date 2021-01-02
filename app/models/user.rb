# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :async, :registerable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable

  api_guard_associations refresh_token: 'refresh_tokens', blacklisted_token: 'blacklisted_tokens'

  has_many :refresh_tokens, dependent: :delete_all
  has_many :blacklisted_tokens, dependent: :delete_all

  def authenticate(password)
    valid_password?(password)
  end
end
