require 'rails_helper'

RSpec.describe "V1::Banks", type: :request do
	before(:each) do
		@current_user = FactoryGirl.create(:user)
		credentials = {email: @current_user.email, password: @current_user.password}
		post v1_authenticate_path, params: credentials.to_json, headers: { 'Content-Type': 'application/vnd.api+json' }
		token = JSON.parse(response.body)['data']['attributes']['token']
		@headers = {  "Content-Type" => "application/vnd.api+json", "Authorization" => "Bearer #{token}" }
	end
		
	describe "GET /banks" do
		it "returns an array containing all banks" do
			get v1_banks_path, headers: @headers
			expect(response).to have_http_status(200)
		end
	end
end
