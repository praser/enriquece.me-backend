require 'rails_helper'

RSpec.describe V1::AuthenticationsController, type: :controller do
  before(:all){ @headers = { 'Content-Type': 'application/vnd.api+json' } }
  before(:each) { @user = FactoryGirl.create(:user) }

  let(:valid_credentials) {
    {
      email: @user.email,
      password: @user.password
    }
  }

  let(:invalid_credentials) {
    {
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }
  }

  describe "POST #create" do
    context "with valid params" do
      before(:each) do
        post :create, params: valid_credentials, headers: @headers
        @body = JSON.parse(response.body)
      end
      
      it "response must contain a token" do
        expect(@body['data']['attributes'].keys).to include 'token'
      end
    end

    context "with invalid params" do
      before(:each) do
        post :create, params: invalid_credentials, headers: @headers
        @body = JSON.parse(response.body)
      end

      it "response must contain an error" do
        expect(@body.keys).to include 'errors'
      end
    end
  end
end
