require 'rails_helper'
RSpec.describe V1::AccountTypesController, type: :controller do
	before(:each) do
		user = FactoryGirl.create(:user)
		allow(controller).to receive(:authenticate_request).and_return(user)
		allow(controller).to receive(:current_user).and_return(user)
	end

	describe "GET #index" do
		it "assigns all accont types as @account_types" do
			5.times do
				FactoryGirl.create(:account_type)
			end

			get :index
			expect(assigns(:account_types).count).to eq AccountType.count
		end
	end
end

