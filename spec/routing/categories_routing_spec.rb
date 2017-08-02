# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::CategoriesController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      expect(get: 'http://api.example.com/categories').to route_to(
        controller: "#{default_version}/categories",
        action: 'index',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #create' do
      expect(post: 'http://api.example.com/categories').to route_to(
        controller: "#{default_version}/categories",
        action: 'create',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: 'http://api.example.com/categories/1').to route_to(
        controller: "#{default_version}/categories",
        action: 'update',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'http://api.example.com/categories/1').to route_to(
        controller: "#{default_version}/categories",
        action: 'update',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'http://api.example.com/categories/1').to route_to(
        controller: "#{default_version}/categories",
        action: 'destroy',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end
  end
end
