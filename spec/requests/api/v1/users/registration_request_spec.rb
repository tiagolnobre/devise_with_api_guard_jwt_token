# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/api/v1/users', type: :request do
  def response_body
    JSON.parse(response.body)
  end

  let(:url) { '/api/v1/users' }

  describe 'POST /api/v1/users' do
    let(:params) do
      {
        email: 'user@example.com',
        password: 'password'
      }
    end

    context 'when user is unauthenticated' do
      before { post url, params: params }

      it 'returns 200' do
        expect(response).to have_http_status(:ok)
        expect(response_body['result']['id']).not_to be_empty
        expect(response_body['result']['email']).to eq params[:email]
        # expect(response_body["first_name"]).to eq user.first_name
        # expect(response_body["last_name"]).to eq user.last_name
      end
    end

    context 'when user already exists' do
      before do
        create(:user, email: params[:email])
        post url, params: params
      end

      it 'returns 422' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_body['errors']).to match('email' => ['has already been taken'])
      end
    end
  end
end
