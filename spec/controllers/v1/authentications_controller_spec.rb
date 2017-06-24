# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::AuthenticationsController, type: :controller do
  before(:each) { @user = FactoryGirl.create(:user) }

  let(:valid_credentials) do
    {
      email: @user.email,
      password: @user.password
    }
  end

  let(:invalid_credentials) do
    {
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      before(:each) do
        post :create, params: valid_credentials, format: :json
        @body = JSON.parse(response.body)
      end

      it 'response must contain a token' do
        expect(@body['data']['attributes'].keys).to include 'token'
      end
    end

    context 'with invalid params' do
      before(:each) do
        post :create, params: invalid_credentials, format: :json
        @body = JSON.parse(response.body)
      end

      it 'response must contain an error' do
        expect(@body.keys).to include 'errors'
      end
    end
  end
end
