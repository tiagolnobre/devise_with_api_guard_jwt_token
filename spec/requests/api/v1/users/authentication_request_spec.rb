# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/users', type: :request do
  def response_body
    JSON.parse(response.body)
  end

  let(:user) { create(:user) }

  describe 'POST /api/v1/users/sign_in' do
    let(:url) { '/api/v1/users/sign_in' }
    let(:params) do
      {
        email: user.email,
        password: user.password
      }
    end

    context 'when params are correct' do
      before { post url, params: params }

      it 'returns JTW token in authorization header' do
        expect(response).to have_http_status(:ok)

        expect(response.headers['Access-Token']).to be_present
        expect(response.headers['Refresh-Token']).to be_present

        decoded_token = JWT.decode(response.headers['Access-Token'], ApiGuard.token_signing_secret)
        expect(decoded_token.first['user_id']).to eq(user.id)
      end
    end

    context 'when login params are incorrect' do
      before do
        post url, params: params.merge(password: 'wrong_password')
      end

      it 'returns 422' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['error']).to eq('Invalid login credentials')
      end
    end
  end

  describe 'DELETE /api/v1/users/sign_out' do
    let(:url) { '/api/v1/users/sign_out' }
    let(:headers) do
      {
        Authorization: "Bearer #{token.first}"
      }
    end

    let(:token) { jwt_and_refresh_token(user, 'user') }

    before { delete url, headers: headers }

    it 'returns 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
