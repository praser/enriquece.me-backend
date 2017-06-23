# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::UserControllers', type: :request do
  context 'with authentication token' do
    before(:each) do
      user = FactoryGirl.create(:user)
      credentials = { email: user.email, password: user.password }

      post(
        v1_authenticate_path,
        params: credentials.to_json,
        headers: { 'Content-Type': 'application/vnd.api+json' }
      )
      token = JSON.parse(response.body)['data']['attributes']['token']

      @headers = {
        'Content-Type' => 'application/vnd.api+json',
        'Authorization' => "Bearer #{token}"
      }
    end

    describe 'GET v1/user' do
      before(:each) do
        get v1_user_path, headers: @headers
      end

      it 'return http status 200' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'POST v1/users' do
      before(:each) do
        post v1_users_path, params: user_params.to_json, headers: @headers
      end

      let(:user_params) { FactoryGirl.attributes_for(:user) }

      it 'returns http status 201' do
        expect(response).to have_http_status :created
      end
    end

    describe 'PUT v1/users/:id' do
      before(:each) do
        put v1_user_path, params: user_params.to_json, headers: @headers
      end

      let(:user) { FactoryGirl.create(:user) }
      let(:user_params) { FactoryGirl.attributes_for(:user) }

      it 'returns http status 200' do
        expect(response).to have_http_status :ok
      end
    end

    describe 'DELETE v1/users/:id' do
      before(:each) do
        delete v1_user_path, headers: @headers
      end

      it 'returns http status 204' do
        expect(response).to have_http_status :no_content
      end
    end
  end

  context 'without authentication token' do
    before(:each) do
      @headers = { 'Content-Type' => 'application/vnd.api+json' }
    end

    describe 'GET v1/user' do
      before(:each) do
        get v1_user_path, headers: @headers
      end

      it 'returns http status 401' do
        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'POST v1/users' do
      before(:each) do
        post v1_users_path, params: user_params.to_json, headers: @headers
      end

      let(:user_params) { FactoryGirl.attributes_for(:user) }

      it 'returns http status 201' do
        expect(response).to have_http_status :created
      end
    end

    describe 'PUT v1/users/:id' do
      before(:each) do
        put v1_user_path, params: user_params.to_json, headers: @headers
      end

      let(:user) { FactoryGirl.create(:user) }
      let(:user_params) { FactoryGirl.attributes_for(:user) }

      it 'returns http status 401' do
        expect(response).to have_http_status :unauthorized
      end
    end

    describe 'DELETE v1/users/:id' do
      before(:each) do
        delete v1_user_path, headers: @headers
      end

      it 'returns http status 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
