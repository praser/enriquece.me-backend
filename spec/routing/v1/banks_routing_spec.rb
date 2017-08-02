# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BanksController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      expect(get: 'http://api.example.com/banks').to route_to(
        controller: "#{default_version}/banks",
        action: 'index',
        subdomain: 'api',
        format: 'json'
      )
    end
  end
end
