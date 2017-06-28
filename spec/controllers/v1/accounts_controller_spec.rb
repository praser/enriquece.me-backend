# frozen_string_literal: true

require 'rails_helper'
RSpec.describe V1::AccountsController, type: :controller do
  before :each do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    before(:each) do
      5.times do
        FactoryGirl.create(:account)
        FactoryGirl.create(:account, user: user)
      end
    end

    it 'assigns all users accounts as @accounts' do
      get :index
      expect(assigns(:accounts)).to eq(Account.where(user: user.id))
    end
  end

  describe 'GET #show' do
    let(:account) { FactoryGirl.create(:account, user: user) }

    it 'assigns the requested account as @account' do
      get :show, params: { id: account.id }
      expect(assigns(:account)).to eq(account)
    end

    it "does not assings another's user account as @account" do
      anothers_account = FactoryGirl.create(:account)

      get :show, params: { id: anothers_account.id }
      expect(assigns(:account)).to be_nil
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Account' do
        expect do
          post :create, params: FactoryGirl.build(:account).attributes
        end.to change(Account, :count).by(1)
      end

      it 'assigns a newly created account as @account' do
        post :create, params: FactoryGirl.build(:account).attributes
        expect(assigns(:account)).to be_a(Account)
        expect(assigns(:account)).to be_persisted
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved account as @account' do
        post :create, params: FactoryGirl.attributes_for(:account)
        expect(assigns(:account)).to be_a_new(Account)
      end
    end
  end

  describe 'PUT #update' do
    let(:account) { FactoryGirl.create(:account, user: user) }
    let(:attributes) { FactoryGirl.attributes_for(:account, id: account.id) }

    it 'updates the requested v1_account' do
      put :update, params: attributes
      account.reload
      expect(account.name).to eq attributes[:name]
      expect(account.description).to eq attributes[:description]
      expect(account.initial_balance.to_s).to eq attributes[:initial_balance]
    end

    it 'assigns the requested account as @account' do
      put :update, params: attributes
      expect(assigns(:account)).to eq(account)
    end

    it 'does not return accounts that not belongs to current_user' do
      new_account = FactoryGirl.create(:account)
      attributes[:id] = new_account.id.to_s
      put :update, params: attributes
      expect(assigns(:account)).to be_nil
    end
  end

  describe 'DELETE #destroy' do
    let(:account) { FactoryGirl.create(:account, user: user) }

    it 'destroys the requested account' do
      delete :destroy, params: { id: account.id }
      expect(Account.all.to_a).to_not include account
    end
  end
end
