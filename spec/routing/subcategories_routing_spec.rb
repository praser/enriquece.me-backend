# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::SubcategoriesController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #create' do
      expect(post: '/subcategories').to route_to(
        "#{default_version}/subcategories#create",
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/subcategories/1').to route_to(
        "#{default_version}/subcategories#update",
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/subcategories/1').to route_to(
        "#{default_version}/subcategories#update",
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/subcategories/1').to route_to(
        "#{default_version}/subcategories#destroy",
        id: '1',
        format: 'json'
      )
    end
  end
end
