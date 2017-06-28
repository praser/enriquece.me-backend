# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Authentications', type: :request do
  before(:all) { @headers = { 'Content-Type': 'application/vnd.api+json' } }
  before(:each) { @user = FactoryGirl.create(:user) }

  let :valid_credentials do
    {
      email: @user.email,
      password: @user.password
    }
  end

  let :invalid_credentials do
    {
      email: @user.email,
      password: 'invalid'
    }
  end

  describe 'GET /v1/authenticate' do
    context 'with valid credentials' do
      it 'returns http status 200' do
        post(
          v1_authenticate_path,
          params: valid_credentials.to_json,
          headers: @headers
        )

        expect(response).to have_http_status(200)
      end
    end

    context	'with invalid credentials' do
      it 'returns http status 401' do
        post(
          v1_authenticate_path,
          params: invalid_credentials.to_json,
          headers: @headers
        )
        expect(response).to have_http_status(401)
      end
    end
  end
end
