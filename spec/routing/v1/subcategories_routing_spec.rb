# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/v1/subcategories').to route_to(
        'v1/subcategories#create',
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: '/v1/subcategories/1').to route_to(
        'v1/subcategories#update',
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/v1/subcategories/1').to route_to(
        'v1/subcategories#update',
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #destroy' do
      expect(delete: '/v1/subcategories/1').to route_to(
        'v1/subcategories#destroy',
        id: '1',
        format: 'json'
      )
    end
  end
end
