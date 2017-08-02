# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::AccountTypes', type: :request do
  within_subdomain :api do
    context 'with authentication token' do
      before(:each) do
        user = FactoryGirl.create(:user)
        credentials = {
          email: user.email,
          password: user.password
        }

        headers = { 'Content-Type': 'application/vnd.api+json' }
        post v1_authenticate_path, params: credentials.to_json, headers: headers

        token = JSON.parse(response.body)['data']['attributes']['token']

        @headers = {
          'Content-Type' => 'application/vnd.api+json',
          'Authorization' => "Bearer #{token}"
        }
      end

      describe 'GET /v1/account_types' do
        it 'returns http status 200' do
          get v1_account_types_path, headers: @headers
          expect(response).to have_http_status(200)
        end
      end
    end

    context 'without authentication token' do
      before(:all) do
        @headers = { 'Content-Type' => 'application/vnd.api+json' }
      end

      describe 'GET /v1/account_types' do
        it 'returns http status 401' do
          get v1_account_types_path, headers: @headers
          expect(response).to have_http_status :unauthorized
        end
      end
    end
  end
end
