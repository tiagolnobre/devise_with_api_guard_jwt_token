# frozen_string_literal: true

class RefreshToken < ApplicationRecord
  belongs_to :user
end
