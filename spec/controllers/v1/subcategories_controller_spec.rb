# rubocop:disable Metrics/BlockLength
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::SubcategoriesController, type: :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category) }

  describe 'POST #create' do
    let(:valid_attributes) do
      FactoryGirl.attributes_for(:subcategory, category_id: category.id.to_s)
    end

    let(:invalid_attributes) do
      FactoryGirl.attributes_for(:subcategory, name: nil)
    end

    context 'with valid params' do
      it 'creates a new Subcategory' do
        expect do
          post :create, params: valid_attributes
        end.to change(Subcategory, :count).by(1)
      end

      it 'assigns a newly created subcategory as @subcategory' do
        post :create, params: valid_attributes
        expect(assigns(:subcategory)).to be_a(Subcategory)
        expect(assigns(:subcategory)).to be_persisted
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved subcategory as @subcategory' do
        post :create, params: invalid_attributes
        expect(assigns(:subcategory)).to be_a_new(Subcategory)
        expect(assigns(:subcategory)).to_not be_persisted
      end

      it 'add validation errors to @category' do
        post :create, params: invalid_attributes
        expect(assigns(:subcategory).errors).to_not be_empty
      end
    end
  end
end
