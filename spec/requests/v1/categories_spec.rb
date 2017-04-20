require 'rails_helper'

RSpec.describe "V1::Categories", type: :request do
	let(:category_params) {FactoryGirl.attributes_for(:category)}
	
	context "with authentication token" do
		before(:each) do
			@current_user = FactoryGirl.create(:user)
			credentials = {email: @current_user.email, password: @current_user.password}
			post v1_authenticate_path, params: credentials.to_json, headers: {'Content-Type': 'application/vnd.api+json'}
			token = JSON.parse(response.body)['data']['attributes']['token']
			@headers = {"Content-Type" => "application/vnd.api+json", "Authorization" => "Bearer #{token}"}
		end

		describe "POST /v1_categories" do
			it "returns http status 201" do
				post v1_categories_path, params: category_params.to_json, headers: @headers
				expect(response).to have_http_status :created
			end
		end
	end

	context "without authentication token" do
		before(:each) do
			@headers = {"Content-Type" => "application/vnd.api+json"}
		end

		describe "POST /v1_categories" do
			it "returns http status 401" do
				post v1_categories_path, params: category_params.to_json, headers: @headers
				expect(response).to have_http_status :unauthorized
			end
		end
	end
end
