# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'http://api.exemple.com/v1/user').to route_to(
        controller: 'v1/users',
        action: 'show',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #create' do
      expect(post: 'http://api.exemple.com/v1/users').to route_to(
        controller: 'v1/users',
        action: 'create',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #update' do
      expect(put: 'http://api.exemple.com/v1/user').to route_to(
        controller: 'v1/users',
        action: 'update',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'http://api.exemple.com/v1/user').to route_to(
        controller: 'v1/users',
        action: 'destroy',
        subdomain: 'api',
        format: 'json'
      )
    end
  end
end
