# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Banks', type: :request do
  within_subdomain :api do
    context 'with authentication token' do
      before(:each) do
        user = FactoryGirl.create(:user)
        credentials = { email: user.email, password: user.password }

        post(
          v1_authenticate_path,
          params: credentials.to_json,
          headers: { 'Content-Type' => 'application/vnd.api+json' }
        )
        token = JSON.parse(response.body)['data']['attributes']['token']

        @headers = {
          'Content-Type' => 'application/vnd.api+json',
          'Authorization' => "Bearer #{token}"
        }
      end

      describe 'GET /banks' do
        it 'returns http 200' do
          get v1_banks_path, headers: @headers
          expect(response).to have_http_status(200)
        end
      end
    end

    context 'without authentication token' do
      before(:each) do
        @headers = { 'Content-Type' => 'application/vnd.api+json' }
      end

      describe 'GET #index' do
        it 'returns http 401' do
          get v1_banks_path, headers: @headers
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
