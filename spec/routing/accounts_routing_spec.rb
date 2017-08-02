# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AccountsController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      expect(get: 'http://api.example.com/accounts').to route_to(
        controller: "#{default_version}/accounts",
        action: 'index',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #show' do
      expect(get: 'http://api.example.com/accounts/1').to route_to(
        controller: "#{default_version}/accounts",
        action: 'show',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #create' do
      expect(post: 'http://api.example.com/accounts').to route_to(
        controller: "#{default_version}/accounts",
        action: 'create',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: 'http://api.example.com/accounts/1').to route_to(
        controller: "#{default_version}/accounts",
        action: 'update',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'http://api.example.com/accounts/1').to route_to(
        controller: "#{default_version}/accounts",
        action: 'update',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'http://api.example.com/accounts/1').to route_to(
        controller: "#{default_version}/accounts",
        action: 'destroy',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end
  end
end
