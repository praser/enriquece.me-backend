# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::SubcategoriesController, type: :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let(:user) { FactoryGirl.create(:user) }
  let(:category) { FactoryGirl.create(:category, user: user) }

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

  describe 'PUT #update' do
    let(:subcategory) { FactoryGirl.create(:subcategory, category: category) }

    context 'with valid params' do
      let(:update_params) do
        FactoryGirl.attributes_for(:subcategory, id: subcategory.id)
      end

      before(:each) do
        put :update, params: update_params
      end

      it 'updates the requested subcategory' do
        subcategory.reload
        expect(subcategory.name).to eq update_params[:name]
      end

      it 'assigns the requested subcategory as @subcategory' do
        expect(assigns(:subcategory)).to eq(subcategory)
      end
    end

    context 'with invalid params' do
      let(:update_params) do
        FactoryGirl.attributes_for(:subcategory, id: subcategory.id, name: nil)
      end

      before(:each) do
        put :update, params: update_params
      end

      it 'assigns the subcategory as @subcategory' do
        expect(assigns(:subcategory)).to eq(subcategory)
      end

      it 'add validation errors to @subcategory' do
        expect(assigns(:subcategory).errors).to_not be_empty
      end
    end

    context 'anothers user subcategory' do
      let(:another_user_subcategory) { FactoryGirl.create(:subcategory) }
      let(:update_params) do
        FactoryGirl.attributes_for(
          :subcategory,
          id: another_user_subcategory.id
        )
      end

      it 'does not assign another_user_subcategory as @subcategory' do
        put :update, params: update_params
        expect(assigns(:subcategory)).to be_nil
      end
    end

    describe 'DELETE #destroy' do
      let(:subcategory) { FactoryGirl.create(:subcategory, category: category) }
      let(:another_user_subcategory) { FactoryGirl.create(:subcategory) }

      it 'destroys the requested subcategory' do
        delete :destroy, params: { id: subcategory.id }
        expect(Subcategory.find(subcategory)).to be_nil
      end

      it 'does not destroys anthers user subcategory' do
        delete :destroy, params: { id: another_user_subcategory.id }
        expect(Subcategory.find(another_user_subcategory)).to_not be_nil
      end
    end
  end
end
