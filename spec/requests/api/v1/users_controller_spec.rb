# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  def response_body
    JSON.parse(response.body)
  end

  describe 'GET /api/v1/user' do
    let(:url) { '/api/v1/user' }
    let(:user) { create(:user) }

    before { get url, headers: headers }

    context 'with invalid auth header' do
      let(:headers) { { 'Authorization' => 'Bearer invalid_jwt' } }

      it 'failed authentication' do
        expect(response).to have_http_status(:unauthorized)
        expect(response_body['error']).to eq('Invalid access token')
      end
    end

    context 'with missing auth header' do
      let(:headers) { nil }

      it 'failed authentication' do
        expect(response).to have_http_status(:unauthorized)
        expect(response_body['error']).to eq('Access token is missing in the request')
      end
    end

    context 'with expired jwt token' do
      let(:headers) { { 'Authorization' => "Bearer #{jwt_and_refresh_token(user, 'user', true).first}" } }

      it 'failed authentication' do
        expect(response).to have_http_status(:unauthorized)
        expect(response_body['error']).to eq('Access token expired')
      end
    end

    context 'with valid auth header' do
      let(:headers) { { 'Authorization' => "Bearer #{jwt_and_refresh_token(user, 'user').first}" } }

      it 'return user data' do
        expect(response).to have_http_status(:ok)
        expect(response.request.headers['Authorization']).to match(/#{headers['Authorization']}/)
        expect(response_body['result']['id']).to eq(user.id)
        expect(response_body['result']['email']).to eq(user.email)
      end
    end
  end
end
