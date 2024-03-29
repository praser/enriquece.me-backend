# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AccountTypesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'http://api.example.com/v1/account_types').to route_to(
        controller: 'v1/account_types',
        action: 'index',
        format: 'json',
        subdomain: 'api'
      )
    end
  end
end
