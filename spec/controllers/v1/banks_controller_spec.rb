# frozen_string_literal: true

require 'rails_helper'
RSpec.describe V1::BanksController, type: :controller do
  before(:each) do
    user = FactoryGirl.create(:user)
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'assigns all banks as @banks' do
      bank = FactoryGirl.create(:bank)
      get :index
      expect(assigns(:banks)).to eq([bank])
    end
  end
end
