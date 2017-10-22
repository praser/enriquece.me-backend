# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BalancesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'http://api.example.com/v1/balances').to route_to(
        controller: 'v1/balances',
        action: 'index',
        subdomain: 'api',
        format: 'json'
      )
    end
  end
end
