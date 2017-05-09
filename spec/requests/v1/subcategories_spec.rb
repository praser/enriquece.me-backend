require 'rails_helper'

RSpec.describe "V1::Subcategories", type: :request do
	context "with authentication token" do
		before(:each) do
			@current_user = FactoryGirl.create(:user)
			credentials = {email: @current_user.email, password: @current_user.password}
			post v1_authenticate_path, params: credentials.to_json, headers: {'Content-Type': 'application/vnd.api+json'}
			token = JSON.parse(response.body)['data']['attributes']['token']
			@headers = {"Content-Type" => "application/vnd.api+json", "Authorization" => "Bearer #{token}"}
		end

		let(:category) {FactoryGirl.create(:category, {user: @current_user})}
		let(:subcategory_params) {FactoryGirl.attributes_for(:subcategory, {category_id: category.id.to_s})}

		describe "POST /v1/subcategories" do
			it "returns http status 201" do
				post v1_subcategories_path, params: subcategory_params.to_json, headers: @headers
				expect(response).to have_http_status :created
			end
		end
	end

	context "without authentication token" do
		before(:each) do
			@headers = {"Content-Type" => "application/vnd.api+json"}
		end

		let(:subcategory_params) {FactoryGirl.attributes_for(:subcategory)}

		describe "POST /v1/subcategories" do
			it "returns http status 401" do
				post v1_subcategories_path, params: subcategory_params.to_json, headers: @headers
				expect(response).to have_http_status :unauthorized
			end
		end
	end
end
