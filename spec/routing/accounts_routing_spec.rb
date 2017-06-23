# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AccountsController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      expect(get: '/accounts').to route_to(
        controller: "#{default_version}/accounts",
        action: 'index',
        format: 'json'
      )
    end

    it 'routes to #show' do
      expect(get: '/accounts/1').to route_to(
        controller: "#{default_version}/accounts",
        action: 'show',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: '/accounts').to route_to(
        controller: "#{default_version}/accounts",
        action: 'create',
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/accounts/1').to route_to(
        controller: "#{default_version}/accounts",
        action: 'update',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/accounts/1').to route_to(
        controller: "#{default_version}/accounts",
        action: 'update',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/accounts/1').to route_to(
        controller: "#{default_version}/accounts",
        action: 'destroy',
        format: 'json',
        id: '1'
      )
    end
  end
end
