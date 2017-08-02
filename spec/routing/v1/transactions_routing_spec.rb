# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::TransactionsController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      start_date = Faker::Date.backward(30).to_s
      end_date = Faker::Date.forward(30).to_s

      expect(get: 'http://api.example.com/transactions').to route_to(
        controller: "#{default_version}/transactions",
        action: 'index',
        subdomain: 'api',
        format: 'json'
      )

      expect(
        get: "http://api.example.com/transactions/since/#{start_date}"
      ).to route_to(
        controller: "#{default_version}/transactions",
        action: 'index',
        subdomain: 'api',
        format: 'json',
        start: start_date
      )

      expect(
        get: 'http://api.example.com/transactions/'\
             "since/#{start_date}/until/#{end_date}"
      ).to route_to(
        controller: "#{default_version}/transactions",
        action: 'index',
        subdomain: 'api',
        format: 'json',
        start: start_date,
        end: end_date
      )
    end

    it 'routes to #show' do
      expect(get: 'http://api.example.com/transactions/1').to route_to(
        controller: "#{default_version}/transactions",
        action: 'show',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: 'http://api.example.com/transactions').to route_to(
        controller: "#{default_version}/transactions",
        action: 'create',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: 'http://api.example.com/transactions/1').to route_to(
        controller: "#{default_version}/transactions",
        action: 'update',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'http://api.example.com/transactions/1').to route_to(
        controller: "#{default_version}/transactions",
        action: 'update',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(
        delete: 'http://api.example.com/transactions/1'
      ).to route_to(
        controller: "#{default_version}/transactions",
        action: 'destroy',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'route to #destroy with modifier' do
      expect(delete: 'http://api.example.com/transactions/1/all').to route_to(
        controller: "#{default_version}/transactions",
        action: 'destroy',
        subdomain: 'api',
        format: 'json',
        id: '1',
        recurrence: 'all'
      )
    end
  end
end
