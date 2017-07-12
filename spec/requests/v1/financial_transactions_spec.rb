# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::FinancialTransactions', type: :request do
  let(:current_user) { FactoryGirl.create(:user) }

  let(:financial_transaction) do
    FactoryGirl.create(:financial_transaction, user: current_user)
  end

  context 'with authentication token' do
    before(:each) do
      credentials = {
        email: current_user.email,
        password: current_user.password
      }

      headers = { 'Content-Type': 'application/vnd.api+json' }
      post v1_authenticate_path, params: credentials.to_json, headers: headers
      token = JSON.parse(response.body)['data']['attributes']['token']
      @headers = {
        'Content-Type' => 'application/vnd.api+json',
        'Authorization' => "Bearer #{token}"
      }
    end

    describe 'GET v1/financial_transactions/:id' do
      it 'returns http status 200' do
        get(
          v1_financial_transaction_path(financial_transaction),
          headers: @headers
        )

        expect(response).to have_http_status(:ok)
      end
    end

    describe 'POST v1/financial_transactions' do
      before(:each) do
        post(
          v1_financial_transactions_path,
          params: financial_transaction_params.to_json,
          headers: @headers
        )
      end

      let(:financial_transaction_params) do
        f = FactoryGirl.build(:financial_transaction)

        FactoryGirl.attributes_for(
          :financial_transaction,
          category_id: f.category_id.to_s,
          subcategory_id: f.subcategory_id.to_s,
          account_id: f.account_id.to_s
        )
      end

      it 'returns http status 201' do
        expect(response).to have_http_status :created
      end
    end

    describe 'PUT /v1/financial_transctions/:id' do
      before(:each) do
        put(
          v1_financial_transaction_path(financial_transaction),
          params: financial_transaction_params.to_json,
          headers: @headers
        )
      end

      let(:financial_transaction_params) do
        f = FactoryGirl.build(:financial_transaction)

        FactoryGirl.attributes_for(
          :financial_transaction,
          category_id: f.category_id.to_s,
          subcategory_id: f.subcategory_id.to_s,
          account_id: f.account_id.to_s
        )
      end

      it 'returns http status 200' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'PATCH /v1/financial_transctions/:id' do
      before(:each) do
        patch(
          v1_financial_transaction_path(financial_transaction),
          params: financial_transaction_params.to_json,
          headers: @headers
        )
      end

      let(:financial_transaction_params) do
        f = FactoryGirl.build(:financial_transaction)

        FactoryGirl.attributes_for(
          :financial_transaction,
          category_id: f.category_id.to_s,
          subcategory_id: f.subcategory_id.to_s,
          account_id: f.account_id.to_s
        )
      end

      let(:financial_transaction) do
        FactoryGirl.create(:financial_transaction, user: current_user)
      end

      it 'returns http status 200' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'DELETE /v1/financial_transactions/:id' do
      before(:each) do
        delete(
          v1_financial_transaction_path(financial_transaction),
          headers: @headers
        )
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

    describe 'GET v1/financial_transactions/:id' do
      it 'returns http status 401' do
        get(
          v1_financial_transaction_path(financial_transaction),
          headers: @headers
        )

        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe 'POST /v1/financial_transactions' do
      it 'returns http status 401' do
        post(
          v1_financial_transactions_path,
          headers: @headers
        )

        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'PUT /v1/financial_transactions/:id' do
      it 'returns http status 401' do
        put(
          v1_financial_transaction_path(financial_transaction),
          headers: @headers
        )

        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'PATCH /v1/financial_transactions/:id' do
      it 'returns http status 401' do
        patch(
          v1_financial_transaction_path(financial_transaction),
          headers: @headers
        )

        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'DELETE /v1/financial_transactions/:id' do
      it 'returns http status 401' do
        delete(
          v1_financial_transaction_path(financial_transaction),
          headers: @headers
        )

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
