require 'rails_helper'
RSpec.describe V1::AccountsController, type: :controller do
  before (:each) do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)  
  end

  let(:user) {FactoryGirl.create(:user)}

  describe "GET #index" do
    xit "assigns all v1_accounts as @v1_accounts" do
      account = V1::Account.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:v1_accounts)).to eq([account])
    end
  end

  describe "GET #show" do
    xit "assigns the requested v1_account as @v1_account" do
      account = V1::Account.create! valid_attributes
      get :show, params: {id: account.to_param}, session: valid_session
      expect(assigns(:v1_account)).to eq(account)
    end
  end

  describe "POST #create" do
    context "with valid params" do

      it "creates a new Account" do
        expect {
          post :create, params: FactoryGirl.build(:account).attributes
        }.to change(Account, :count).by(1)
      end

      it "assigns a newly created account as @account" do
        post :create, params: FactoryGirl.build(:account).attributes
        expect(assigns(:account)).to be_a(Account)
        expect(assigns(:account)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved account as @account" do
        post :create, params: FactoryGirl.attributes_for(:account)
        expect(assigns(:account)).to be_a_new(Account)
      end
    end
  end

  describe "PUT #update" do
    let(:account) {FactoryGirl.create(:account, {user: user})}
    let(:attributes) {FactoryGirl.attributes_for(:account, {id: account.id})}

    it "updates the requested v1_account" do
      put :update, params: attributes
      account.reload
      expect(account.name).to eq attributes[:name]
      expect(account.description).to eq attributes[:description]
      expect(account.initial_balance.to_s).to eq attributes[:initial_balance]
    end

    it "assigns the requested account as @account" do
      put :update, params: attributes
      expect(assigns(:account)).to eq(account)
    end

    it "does not return accounts that not belongs to current_user" do
      new_account = FactoryGirl.create(:account)
      attributes[:id] = new_account.id.to_s
      put :update, params: attributes
      expect(assigns(:account)).to be_nil
    end
  end

  describe "DELETE #destroy" do
    xit "destroys the requested v1_account" do
      account = V1::Account.create! valid_attributes
      expect {
        delete :destroy, params: {id: account.to_param}, session: valid_session
      }.to change(V1::Account, :count).by(-1)
    end

    xit "redirects to the v1_accounts list" do
      account = V1::Account.create! valid_attributes
      delete :destroy, params: {id: account.to_param}, session: valid_session
      expect(response).to redirect_to(v1_accounts_url)
    end
  end

end
