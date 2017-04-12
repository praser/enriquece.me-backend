require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  context "without authentication token" do
    describe "GET #show" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        get :show, params: {id: user.id}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "POST #create" do
      it "returns http success" do
        post :create, params: FactoryGirl.attributes_for(:user)
        expect(response).to have_http_status(:success)
      end
    end

    describe "PUT #update" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        put :update, params: {id: user.id.to_s}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE #delete" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        delete :destroy, params: {id: user.id}
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context "with authentication token" do
    before(:each) do
      allow(controller).to receive(:authenticate_request).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end

    let(:user) {FactoryGirl.create(:user)}
    
    describe "GET #show" do
      it "returns http unauthorized" do
        get :show, params: {id: user.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "POST #create" do
      it "returns http success" do
        post :create, params: FactoryGirl.attributes_for(:user)
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "PUT #update" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        put :update, params: {id: user.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "DELETE #delete" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        delete :destroy, params: {id: user.id}
        expect(response).to have_http_status(:success)
      end
    end
  end
end
