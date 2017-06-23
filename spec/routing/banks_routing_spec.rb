# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::BanksController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      expect(get: '/banks').to route_to(
        controller: "#{default_version}/banks",
        action: 'index',
        format: 'json'
      )
    end
  end
end
