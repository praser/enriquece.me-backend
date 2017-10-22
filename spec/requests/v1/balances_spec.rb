# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Balances', type: :request do
  within_subdomain :api do
    let(:current_user) { FactoryGirl.create(:user) }

    context 'with authentication token' do
      before(:each) do
        credentials = {
          email: current_user.email,
          password: current_user.password
        }

        headers = { 'Content-Type' => 'application/vnd.api+json' }
        post v1_authenticate_path, params: credentials.to_json, headers: headers
        token = JSON.parse(response.body)['data']['attributes']['token']
        @headers = {
          'Content-Type' => 'application/vnd.api+json',
          'Authorization' => "Bearer #{token}"
        }
      end

      describe 'GET v1/balances' do
        it 'returns http status 401' do
          get v1_balances_path, headers: @headers
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'GET v1/balances/since/:start/until/:end' do
        let(:start_date) { Faker::Date.backward(30).to_s }
        let(:end_date) { Faker::Date.forward(30).to_s }

        it 'returns http status 401' do
          get(
            v1_balance_since_until_path(start_date, start_date),
            headers: @headers
          )

          expect(response).to have_http_status(:ok)
        end
      end

      describe 'GET V1/balances/account/:account' do
        let(:account) { FactoryGirl.create(:account, user: current_user) }

        it 'returns http stats 401' do
          get(v1_balance_account_path(account.id.to_s), headers: @headers)
          expect(response).to have_http_status(:ok)
        end
      end

      describe 'GET V1/balances/account/:account/since/:start/until/:end' do
        let(:account) { FactoryGirl.create(:account, user: current_user) }
        let(:start_date) { Faker::Date.backward(30).to_s }
        let(:end_date) { Faker::Date.forward(30).to_s }

        it 'returns http stats 401' do
          get(
            v1_balance_account_since_until_path(
              account.id.to_s,
              start_date,
              end_date
            ),
            headers: @headers
          )
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'withou authentication token' do
      before(:each) do
        @headers = { 'Content-Type' => 'application/vnd.api+json' }
      end

      describe 'GET v1/balances' do
        it 'returns http status 401' do
          get v1_balances_path, headers: @headers
          expect(response).to have_http_status(:unauthorized)
        end
      end

      describe 'GET v1/balances/since/:start/until/:end' do
        let(:start_date) { Faker::Date.backward(30).to_s }
        let(:end_date) { Faker::Date.forward(30).to_s }

        it 'returns http status 401' do
          get(
            v1_balance_since_until_path(start_date, start_date),
            headers: @headers
          )

          expect(response).to have_http_status(:unauthorized)
        end
      end

      describe 'GET V1/balances/account/:account' do
        let(:account) { FactoryGirl.create(:account, user: current_user) }

        it 'returns http stats 401' do
          get(v1_balance_account_path(account.id.to_s), headers: @headers)
          expect(response).to have_http_status(:unauthorized)
        end
      end

      describe 'GET V1/balances/account/:account/since/:start/until/:end' do
        let(:account) { FactoryGirl.create(:account, user: current_user) }
        let(:start_date) { Faker::Date.backward(30).to_s }
        let(:end_date) { Faker::Date.forward(30).to_s }

        it 'returns http stats 401' do
          get(
            v1_balance_account_since_until_path(
              account.id.to_s,
              start_date,
              end_date
            ),
            headers: @headers
          )
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
