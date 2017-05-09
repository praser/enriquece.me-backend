require 'rails_helper'
RSpec.describe V1::CategoriesController, type: :controller do
	before (:each) do
		allow(controller).to receive(:authenticate_request).and_return(user)
		allow(controller).to receive(:current_user).and_return(user)
	end

	let(:user) {FactoryGirl.create(:user)}

	describe "GET #index" do
		5.times do
			FactoryGirl.create(:category)
		end

		it "assigns all user's categories as @categories" do
			5.times {FactoryGirl.create(:category, {user: user})}
			
			get :index
			expect(assigns(:categories)).to eq(Category.where(user_id: user.id))
		end
	end

	describe "POST #create" do
		let(:valid_attributes) {
			FactoryGirl.attributes_for(:category)
		}

		let(:invalid_attributes) {
			FactoryGirl.attributes_for(:category, {name: nil})
		}
		context "with valid params" do
			it "creates a new Category" do
				expect {
					post :create, params: valid_attributes
				}.to change(Category, :count).by(1)
			end

			it "assigns a newly created category as @category" do
				post :create, params: valid_attributes
				expect(assigns(:category)).to be_a(Category)
				expect(assigns(:category)).to be_persisted
			end
		end

		context "with invalid params" do
			it "assigns a newly created but unsaved category as @category" do
				post :create, params: invalid_attributes
				expect(assigns(:category)).to be_a_new(Category)
				expect(assigns(:category)).to_not be_persisted
			end

			it "add validation errors to @category" do
				post :create, params: invalid_attributes
				expect(assigns(:category).errors).to_not be_empty
			end
		end
	end

	describe "PUT #update" do
		let(:category) {FactoryGirl.create(:category, {user: user})}

		context "with valid params" do
			let(:update_params) {FactoryGirl.attributes_for(:category, {id: category.id})}

			before(:each) do
				put :update, params: update_params
			end

			it "updates the requested category" do
				category.reload
				expect(category.name).to eq update_params[:name]
			end

			it "assigns the requested category as @category" do
				expect(assigns(:category)).to eq(category)
			end
		end

		context "with invalid params" do
			let(:update_params) {FactoryGirl.attributes_for(:category, {id: category.id, name: nil})}

			before(:each) do
				put :update, params: update_params
			end

			it "assigns the category as @category" do
				expect(assigns(:category)).to eq(category)
			end

			it "add validation errors to @category" do
				expect(assigns(:category).errors).to_not be_empty
			end
		end

		context "anothers user categori" do
			let(:another_user_category) {FactoryGirl.create(:category)}
			let(:update_params) {FactoryGirl.attributes_for(:category, {id: another_user_category.id})}

			it "does not assign another_user_category as @category" do
				put :update, params: update_params
				expect(assigns(:category)).to be_nil
			end
		end
	end

	describe "DELETE #destroy" do
		it "destroys the requested category" do
			category = FactoryGirl.create(:category, {user: user})
			expect {
				delete :destroy, params: {id: category.id}
			}.to change(Category, :count).by(-1)
		end
	end

end
