# frozen_string_literal: true

class CreateRefreshTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :refresh_tokens, id: :uuid do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
    add_index :refresh_tokens, :token, unique: true
  end
end
