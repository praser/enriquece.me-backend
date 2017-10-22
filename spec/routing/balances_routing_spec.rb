# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BalancesController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      expect(get: 'http://api.example.com/balances').to route_to(
        controller: "#{default_version}/balances",
        action: 'index',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes do index with date interval' do
      expect(
        get: 'http://api.example.com/balances/since/2017-09-01/until/2017-09-30'
      ).to route_to(
        controller: "#{default_version}/balances",
        action: 'index',
        subdomain: 'api',
        format: 'json',
        start: '2017-09-01',
        end: '2017-09-30'
      )
    end

    it 'routes to index with account' do
      expect(get: 'http://api.example.com/balances/account/abc123').to route_to(
        controller: "#{default_version}/balances",
        action: 'index',
        subdomain: 'api',
        format: 'json',
        account: 'abc123'
      )
    end

    it 'routes to index with account and dante interval' do
      expect(
        get: 'http://api.example.com/balances/account/abc123/since/2017-09-01/'\
             'until/2017-09-30'
      ).to route_to(
        controller: "#{default_version}/balances",
        action: 'index',
        subdomain: 'api',
        format: 'json',
        account: 'abc123',
        start: '2017-09-01',
        end: '2017-09-30'
      )
    end
  end
end
