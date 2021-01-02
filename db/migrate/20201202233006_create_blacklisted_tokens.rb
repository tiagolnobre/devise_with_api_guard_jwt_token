# frozen_string_literal: true

class CreateBlacklistedTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :blacklisted_tokens, id: :uuid do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.datetime :expire_at

      t.timestamps
    end
  end
end
