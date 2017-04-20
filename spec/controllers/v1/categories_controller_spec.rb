require 'rails_helper'
RSpec.describe V1::CategoriesController, type: :controller do
  before (:each) do
    user = FactoryGirl.create(:user)
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)  
  end

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:category)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:category, {name: nil})
  }

  describe "GET #index" do
    xit "assigns all v1_categories as @v1_categories" do
      category = V1::Category.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:v1_categories)).to eq([category])
    end
  end

  describe "GET #show" do
    xit "assigns the requested v1_category as @v1_category" do
      category = V1::Category.create! valid_attributes
      get :show, params: {id: category.to_param}, session: valid_session
      expect(assigns(:v1_category)).to eq(category)
    end
  end

  describe "POST #create" do
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
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      xit "updates the requested v1_category" do
        category = V1::Category.create! valid_attributes
        put :update, params: {id: category.to_param, v1_category: new_attributes}, session: valid_session
        category.reload
        skip("Add assertions for updated state")
      end

      xit "assigns the requested v1_category as @v1_category" do
        category = V1::Category.create! valid_attributes
        put :update, params: {id: category.to_param, v1_category: valid_attributes}, session: valid_session
        expect(assigns(:v1_category)).to eq(category)
      end

      xit "redirects to the v1_category" do
        category = V1::Category.create! valid_attributes
        put :update, params: {id: category.to_param, v1_category: valid_attributes}, session: valid_session
        expect(response).to redirect_to(category)
      end
    end

    context "with invalid params" do
      xit "assigns the v1_category as @v1_category" do
        category = V1::Category.create! valid_attributes
        put :update, params: {id: category.to_param, v1_category: invalid_attributes}, session: valid_session
        expect(assigns(:v1_category)).to eq(category)
      end

      xit "re-renders the 'edit' template" do
        category = V1::Category.create! valid_attributes
        put :update, params: {id: category.to_param, v1_category: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    xit "destroys the requested v1_category" do
      category = V1::Category.create! valid_attributes
      expect {
        delete :destroy, params: {id: category.to_param}, session: valid_session
      }.to change(V1::Category, :count).by(-1)
    end

    xit "redirects to the v1_categories list" do
      category = V1::Category.create! valid_attributes
      delete :destroy, params: {id: category.to_param}, session: valid_session
      expect(response).to redirect_to(v1_categories_url)
    end
  end

end
