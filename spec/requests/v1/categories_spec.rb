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

		let(:category) {FactoryGirl.create(:category, {user: @current_user})}

		describe "POST /v1/categories" do
			it "returns http status 201" do
				post v1_categories_path, params: category_params.to_json, headers: @headers
				expect(response).to have_http_status :created
			end
		end

		describe "PUT /v1/categories/:id" do
			it "returns http status 200" do
				put v1_category_path(category), params: category_params.to_json, headers: @headers
				expect(response).to have_http_status :ok
			end
		end

		describe "PATCH /v1/categories/:id" do
			it "returns http status 200" do
				patch v1_category_path(category), params: category_params.to_json, headers: @headers
				expect(response).to have_http_status :ok
			end
		end

		describe "GET /v1/categories" do
			it "returns http status 200" do
				get v1_categories_path, headers: @headers
				expect(response).to have_http_status :ok
			end
		end
	end

	context "without authentication token" do
		before(:each) do
			@headers = {"Content-Type" => "application/vnd.api+json"}
		end

		let(:category) {FactoryGirl.create(:category)}

		describe "POST /v1/categories" do
			it "returns http status 401" do
				post v1_categories_path, params: category_params.to_json, headers: @headers
				expect(response).to have_http_status :unauthorized
			end
		end

		describe "PUT /v1/categories/:id" do
			it "returns http status 401" do
				put v1_category_path(category), headers: @headers
				expect(response).to have_http_status :unauthorized
			end
		end

		describe "PATCH /v1/categories/:id" do
			it "returns http status 401" do
				patch v1_category_path(category), headers: @headers
				expect(response).to have_http_status :unauthorized
			end
		end

		describe "GET /v1/categories/:id" do
			it "returns http status 401" do
				get v1_categories_path, headers: @headers
				expect(response).to have_http_status :unauthorized
			end
		end
	end
end
