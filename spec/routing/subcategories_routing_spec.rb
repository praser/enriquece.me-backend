# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::SubcategoriesController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #create' do
      expect(post: 'http://api.example.com/subcategories').to route_to(
        controller: "#{default_version}/subcategories",
        action: 'create',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: 'http://api.example.com/subcategories/1').to route_to(
        controller: "#{default_version}/subcategories",
        action: 'update',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'http://api.example.com/subcategories/1').to route_to(
        controller: "#{default_version}/subcategories",
        action: 'update',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'http://api.example.com/subcategories/1').to route_to(
        controller: "#{default_version}/subcategories",
        action: 'destroy',
        subdomain: 'api',
        format: 'json',
        id: '1'
      )
    end
  end
end
