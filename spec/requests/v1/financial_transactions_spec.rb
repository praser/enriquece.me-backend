# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::FinancialTransactions', type: :request do
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

      let(:financial_transaction) do
        FactoryGirl.create(:financial_transaction, user: @current_user)
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
        FactoryGirl.create(:financial_transaction, user: @current_user)
      end

      it 'returns http status 200' do
        expect(response).to have_http_status :ok
      end
    end
  end
end
