# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::FinancialTransactionsController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    # it 'ro"tes to #index' do
    #   expect(get: '/v1/financial_transactions').to route_to(
    #     'v1/financial_transactions#index'
    #   )
    # end

    # it 'routes to #show' do
    #   expect(get: '/v1/financial_transactions/1').to route_to(
    #     'v1/financial_transactions#show',
    #     id: '1'
    #   )
    # end

    it 'routes to #create' do
      expect(post: "/#{default_version}/financial_transactions").to route_to(
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

    # it 'routes to #destroy' do
    #   expect(delete: '/v1/financial_transactions/1').to route_to(
    #     'v1/financial_transactions#destroy',
    #     id: '1'
    #   )
    # end
  end
end
