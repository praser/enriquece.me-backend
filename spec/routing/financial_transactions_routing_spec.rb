# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::FinancialTransactionsController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      start_date = Faker::Date.backward(30).to_s
      end_date = Faker::Date.forward(30).to_s

      expect(get: "/#{default_version}/financial_transactions").to route_to(
        "#{default_version}/financial_transactions#index",
        format: 'json'
      )

      expect(
        get: "/#{default_version}/financial_transactions/since/#{start_date}"
      ).to route_to(
        "#{default_version}/financial_transactions#index",
        start: start_date,
        format: 'json'
      )

      expect(
        get: "/#{default_version}/financial_transactions/"\
             "since/#{start_date}/until/#{end_date}"
      ).to route_to(
        "#{default_version}/financial_transactions#index",
        start: start_date,
        end: end_date,
        format: 'json'
      )
    end

    it 'routes to #show' do
      expect(get: "/#{default_version}/financial_transactions/1").to route_to(
        "#{default_version}/financial_transactions#show",
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #create' do
      expect(post: "/#{default_version}/financial_transactions").to route_to(
        "#{default_version}/financial_transactions#create",
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: "/#{default_version}/financial_transactions/1").to route_to(
        "#{default_version}/financial_transactions#update",
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/#{default_version}/financial_transactions/1").to route_to(
        "#{default_version}/financial_transactions#update",
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #destroy' do
      expect(
        delete: "/#{default_version}/financial_transactions/1"
      ).to route_to(
        "#{default_version}/financial_transactions#destroy",
        id: '1',
        format: 'json'
      )
    end
  end
end
