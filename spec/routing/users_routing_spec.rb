# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UsersController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #show' do
      expect(get: 'http://api.exemple.com/user').to route_to(
        controller: "#{default_version}/users",
        action: 'show',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #create' do
      expect(post: 'http://api.exemple.com/users').to route_to(
        controller: "#{default_version}/users",
        action: 'create',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #update' do
      expect(put: 'http://api.exemple.com/user').to route_to(
        controller: "#{default_version}/users",
        action: 'update',
        subdomain: 'api',
        format: 'json'
      )
    end

    it 'routes to #destroy' do
      expect(delete: 'http://api.exemple.com/user').to route_to(
        controller: "#{default_version}/users",
        action: 'destroy',
        subdomain: 'api',
        format: 'json'
      )
    end
  end
end
