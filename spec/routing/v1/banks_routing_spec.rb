# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BanksController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'http://api.example.com/v1/banks').to route_to(
        controller: 'v1/banks',
        action: 'index',
        subdomain: 'api',
        format: 'json'
      )
    end
  end
end
