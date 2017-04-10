require 'rails_helper'

RSpec.describe "V1::UserControllers", type: :request do

	before(:each) do
		@current_user = FactoryGirl.create(:user)
		credentials = {email: @current_user.email, password: @current_user.password}
		post v1_authenticate_path, params: credentials.to_json, headers: { 'Content-Type': 'application/vnd.api+json' }
		token = JSON.parse(response.body)['data']['attributes']['token']
		@headers = {  "Content-Type" => "application/vnd.api+json", "Authorization" => "Bearer #{token}" }
	end

	describe "GET v1/user" do
		before(:each) do
			get v1_user_path, headers: @headers
			@body = JSON.parse(response.body)
		end

		it "return the specified user" do
			expect(response).to have_http_status 200
			expect(@body['data']['attributes']['name']).to eq @current_user.name
			expect(@body['data']['attributes']['email']).to eq @current_user.email
		end
	end

	describe "POST v1/users" do
		before(:each) do
			post v1_users_path, params: user_params.to_json, headers: @headers
			@body = JSON.parse(response.body)
		end

		let(:user_params) {FactoryGirl.attributes_for(:user)}

		it "creates the specified user" do
			expect(response).to have_http_status 201
			expect(@body['data']['attributes']['name']).to eq user_params[:name]
			expect(@body['data']['attributes']['email']).to eq user_params[:email]
		end	
	end

	describe "PUT v1/users/:id" do
		before(:each) do
			put v1_user_path, params: user_params.to_json, headers: @headers
			@body = JSON.parse(response.body)
		end

		let(:user) {FactoryGirl.create(:user)}
		let(:user_params) {FactoryGirl.attributes_for(:user)}	

		it "updates the specified user" do
			expect(response).to have_http_status 200
			expect(@body['data']['attributes']['name']).to eq user_params[:name]
			expect(@body['data']['attributes']['email']).to_not eq user_params[:email]
		end
	end

	describe "DELETE v1/users/:id" do
		before(:each) do
			user = FactoryGirl.create(:user)
			delete v1_user_path, headers: @headers
		end

		it "remove the specified user" do
			expect(response).to have_http_status 204
		end
	end
end