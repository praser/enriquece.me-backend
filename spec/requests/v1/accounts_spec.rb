# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Accounts', type: :request do
  context 'with authentication token' do
    before(:each) do
      @current_user = FactoryGirl.create(:user)
      credentials = {
        email: @current_user.email,
        password: @current_user.password
      }

      headers = { 'Content-Type': 'application/vnd.api+json' }
      post v1_authenticate_path, params: credentials.to_json, headers: headers
      token = JSON.parse(response.body)['data']['attributes']['token']
      @headers = {
        'Content-Type' => 'application/vnd.api+json',
        'Authorization' => "Bearer #{token}"
      }
    end

    describe 'GET v1/accounts' do
      before(:each) do
        get v1_accounts_path, headers: @headers
      end

      it 'return http status 200' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'GET v1/account/:id' do
      before(:each) do
        account = FactoryGirl.create(:account, user: @current_user)
        get v1_account_path(account), headers: @headers
      end

      it 'return http status 200' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'POST v1/accounts' do
      before(:each) do
        post v1_accounts_path, params: account_params.to_json, headers: @headers
      end

      let(:account_params) do
        FactoryGirl.attributes_for(
          :account,
          user: @current_user,
          bank_id: FactoryGirl.create(:bank).id.to_s,
          account_type_id: FactoryGirl.create(:account_type).id.to_s
        )
      end

      it 'returns http status 201' do
        expect(response).to have_http_status :created
      end
    end

    describe 'PUT v1/accounts/:id' do
      let(:account) { FactoryGirl.create(:account, user: @current_user) }
      let(:account_params) { FactoryGirl.attributes_for(:account) }

      before(:each) do
        put(
          v1_account_path(account),
          params: account_params.to_json,
          headers: @headers
        )
      end

      it 'returns http status 200' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'DELETE v1/accounts/:id' do
      before(:each) do
        account = FactoryGirl.create(:account, user: @current_user)
        delete v1_account_path(account), headers: @headers
      end

      it 'returns http status 204' do
        expect(response).to have_http_status :no_content
      end
    end
  end

  context 'without authentication token' do
    before(:each) do
      @headers = { 'Content-Type' => 'application/vnd.api+json' }
    end

    describe 'GET v1/accounts' do
      before(:each) do
        get v1_accounts_path, headers: @headers
      end

      it 'returns http status 401' do
        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'POST v1/accounts' do
      before(:each) do
        post v1_accounts_path, headers: @headers
      end

      it 'returns http status 401' do
        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'PUT v1/accounts/:id' do
      let(:account) { FactoryGirl.create(:account) }

      before(:each) do
        put v1_account_path(account), headers: @headers
      end

      it 'returns http status 401' do
        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'DELETE v1/accounts/:id' do
      before(:each) do
        account = FactoryGirl.create(:account)
        delete v1_account_path(account), headers: @headers
      end

      it 'returns http status 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
