# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::TransactionsController, type: :routing do
  describe 'routing' do
    let(:default_version) { 'v1' }

    it 'routes to #index' do
      start_date = Faker::Date.backward(30).to_s
      end_date = Faker::Date.forward(30).to_s

      expect(get: "/#{default_version}/transactions").to route_to(
        "#{default_version}/transactions#index",
        format: 'json'
      )

      expect(
        get: "/#{default_version}/transactions/since/#{start_date}"
      ).to route_to(
        "#{default_version}/transactions#index",
        start: start_date,
        format: 'json'
      )

      expect(
        get: "/#{default_version}/transactions/"\
             "since/#{start_date}/until/#{end_date}"
      ).to route_to(
        "#{default_version}/transactions#index",
        start: start_date,
        end: end_date,
        format: 'json'
      )
    end

    it 'routes to #show' do
      expect(get: "/#{default_version}/transactions/1").to route_to(
        "#{default_version}/transactions#show",
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #create' do
      expect(post: "/#{default_version}/transactions").to route_to(
        "#{default_version}/transactions#create",
        format: 'json'
      )
    end

    it 'routes to #update via PUT' do
      expect(put: "/#{default_version}/transactions/1").to route_to(
        "#{default_version}/transactions#update",
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/#{default_version}/transactions/1").to route_to(
        "#{default_version}/transactions#update",
        id: '1',
        format: 'json'
      )
    end

    it 'routes to #destroy' do
      expect(
        delete: "/#{default_version}/transactions/1"
      ).to route_to(
        "#{default_version}/transactions#destroy",
        id: '1',
        format: 'json'
      )
    end

    it 'route to #destroy with modifier' do
      expect(delete: "/#{default_version}/transactions/1/all").to route_to(
        "#{default_version}/transactions#destroy",
        id: '1',
        recurrence: 'all',
        format: 'json'
      )
    end
  end
end
