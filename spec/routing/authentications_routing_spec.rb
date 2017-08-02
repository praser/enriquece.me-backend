# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AuthenticationsController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #create' do
      expect(post: 'http://api.example.com/authenticate').to route_to(
        controller: "#{default_version}/authentications",
        action: 'create',
        subdomain: 'api',
        format: 'json'
      )
    end
  end
end
