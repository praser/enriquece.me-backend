# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #show' do
    it 'assigns current_user to @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to be(user)
    end
  end

  describe 'POST #create' do
    before do
      allow(controller).to receive(:authenticate_request).and_return(nil)
      allow(controller).to receive(:current_user).and_return(nil)
    end

    it 'creates a new user' do
      user_attr = FactoryGirl.attributes_for(:user)
      post :create, params: user_attr
      expect(User.find_by(email: user_attr[:email])).to_not be_nil
    end
  end

  describe 'PUT #update' do
    it 'returns http unauthorized' do
      user = FactoryGirl.create(:user)
      user_attr = FactoryGirl.attributes_for(:user)
      put :update, params: user_attr
      expect(user.name).to eq user_attr[:name]
      expect(user.email).to_not eq user_attr[:email]
    end
  end

  describe 'DELETE #delete' do
    it 'returns http unauthorized' do
      delete :destroy
      expect(User.all.to_a).to_not include user
    end
  end
end
