# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::FinancialTransactionsController, type: :routing do
  describe 'routing' do
    let(:start_date) { Faker::Date.backward(30).to_s }
    let(:end_date) { Faker::Date.forward(30).to_s }
    it 'routes to #index' do
      expect(get: '/v1/financial_transactions').to route_to(
        'v1/financial_transactions#index',
        format: 'json'
      )

      expect(
        get: "/v1/financial_transactions/since/#{start_date}"
      ).to route_to(
        'v1/financial_transactions#index',
        start: start_date,
        format: 'json'
      )

      expect(
        get: "/v1/financial_transactions/since/#{start_date}/until/#{end_date}"
      ).to route_to(
        'v1/financial_transactions#index',
        start: start_date,
        end: end_date,
        format: 'json'
      )
    end

    it 'routes to #show' do
      expect(get: '/v1/financial_transactions/1').to route_to(
        'v1/financial_transactions#show',
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #create' do
      expect(post: '/v1/financial_transactions').to route_to(
        'v1/financial_transactions#create',
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/financial_transactions/1').to route_to(
        'v1/financial_transactions#update',
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/financial_transactions/1').to route_to(
        'v1/financial_transactions#update',
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/financial_transactions/1').to route_to(
        'v1/financial_transactions#destroy',
        id: '1',
        format: 'json'
      )
    end
  end
end
