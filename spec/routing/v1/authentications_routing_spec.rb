# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AuthenticationsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'http://api.example.com/v1/authenticate').to route_to(
        controller: 'v1/authentications',
        action: 'create',
        subdomain: 'api',
        format: 'json'
      )
    end
  end
end
