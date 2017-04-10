require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  context "without authentication token" do
    describe "GET #show" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        get :show, id: user.id.to_s
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
        put :update, id: user.id.to_s
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE #delete" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        delete :destroy, id: user.id
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context "with authentication token" do
    describe "GET #show" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        get :show, id: user.id.to_s
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
        put :update, id: user.id.to_s
        expect(response).to have_http_status(:unauthorized)
      end
    end

    describe "DELETE #delete" do
      it "returns http unauthorized" do
        user = FactoryGirl.create(:user)
        delete :destroy, id: user.id
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
