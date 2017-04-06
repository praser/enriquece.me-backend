require 'rails_helper'

RSpec.describe "V1::UserControllers", type: :request do
	describe "GET v1/users" do
		before(:each) do
			5.times {FactoryGirl.create(:user)}
			get v1_users_path
			@body = JSON.parse(response.body)
		end

		it "returns all the users" do
			expect(response).to have_http_status 200
			expect(@body['data'].size).to be_equal User.all.size
		end
	end

	describe "GET v1/users/:id" do
		let(:user) {FactoryGirl::create(:user)}

		before(:each) do
			get v1_user_path user.id
			@body = JSON.parse(response.body)
		end

		it "return the specified user" do
			expect(response).to have_http_status 200
			expect(@body['data']['attributes']['name']).to eq user.name
			expect(@body['data']['attributes']['email']).to eq user.email
		end
	end

	describe "POST v1/users" do
		before(:each) do
			post v1_users_path, params: user_params.to_json, headers: { 'Content-Type': 'application/vnd.api+json' }
			@body = JSON.parse(response.body)
		end

		let(:user_params) {
			{
				data: {
					type: 'users',
					attributes: FactoryGirl.attributes_for(:user)
				}
			}
		}

		it "creates the specified user" do
			expect(response).to have_http_status 201
			expect(@body['data']['attributes']['name']).to eq user_params[:data][:attributes][:name]
			expect(@body['data']['attributes']['email']).to eq user_params[:data][:attributes][:email]
		end	
	end

	describe "PUT v1/users/:id" do
		before(:each) do
			put v1_user_path(user), params: user_params.to_json, headers: { 'Content-Type': 'application/vnd.api+json' }
			@body = JSON.parse(response.body)
		end

		let(:user) {FactoryGirl.create(:user)}
		let(:user_params) do
			{
				data: {
					type: 'users',
					id: user.id,
					attributes: FactoryGirl.attributes_for(:user)
				}
			}	
		end

		it "updates the specified user" do
			expect(response).to have_http_status 200
			expect(@body['data']['attributes']['name']).to eq user_params[:data][:attributes][:name]
			expect(@body['data']['attributes']['email']).to eq user_params[:data][:attributes][:email]
		end
	end

	describe "DELETE v1/users/:id" do
		before(:each) do
			user = FactoryGirl.create(:user)
			delete v1_user_path(user)
		end

		it "remove the specified user" do
			expect(response).to have_http_status 204
		end
	end
end
