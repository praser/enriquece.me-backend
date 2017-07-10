# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::FinancialTransactionsController, type: :controller do
  ActiveJob::Base.queue_adapter = :test

  before(:each) do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let(:user) { FactoryGirl.create(:user) }

  # describe 'GET #index' do
  #   it 'returns a success response' do
  #     financial_transaction = V1::FinancialTransaction.create! valid
  #     get :index, params: {}, session: valid_session
  #     expect(response).to be_success
  #   end
  # end

  # describe 'GET #show' do
  #   it 'returns a success response' do
  #     financial_transaction = V1::FinancialTransaction.create! valid
  #     get :show, params: {id: financial_transaction.to_param}
  #     expect(response).to be_success
  #   end
  # end

  describe 'POST #create' do
    let(:valid) do
      params = FactoryGirl.build(
        :financial_transaction
      ).attributes
      params[:recurrence] = FactoryGirl.attributes_for(:recurrence)

      return params
    end

    let(:invalid) do
      FactoryGirl.attributes_for(:financial_transaction, :invalid)
    end

    context 'with valid params' do
      it 'creates a new FinancialTransaction' do
        expect do
          post :create, params: valid
        end.to change(FinancialTransaction, :count).by(1)
      end

      it 'assigns a newly financial transaction as @financial_transaction' do
        post :create, params: valid
        expect(assigns(:fin_transaction)).to be_a(FinancialTransaction)
        expect(assigns(:fin_transaction)).to be_persisted
      end

      it 'renders a JSON response with the new financial_transaction' do
        post :create, params: valid
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to(
          eq(v1_financial_transaction_path(FinancialTransaction.last))
        )
      end

      it 'creates a new financial transaction belonging to current user' do
        post :create, params: valid
        expect(assigns(:fin_transaction).user).to eq(user)
      end

      it 'is expected to call fin_trans_job when recurrence exists' do
        expect(subject).to receive(:fin_trans_job)
        post :create, params: valid
      end

      it 'is expected to not call fin_trans_job when no recurrence exists' do
        expect(subject).to_not receive(:fin_trans_job)
        post :create, params: valid.except(:recurrence)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors' do
        post :create, params: invalid
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  # describe 'PUT #update' do
  #   context 'with valid params' do
  #     let(:new_attributes) {
  #       skip('Add a hash of attributes valid for your model')
  #     }

  #     it 'updates the requested v1_financial_transaction' do
  #       financial_transaction = V1::FinancialTransaction.create! valid
  #       put :update, params: {
  #         id: financial_transaction.to_param,
  #         v1_financial_transaction: new_attributes
  #       }
  #       financial_transaction.reload
  #       skip('Add assertions for updated state')
  #     end

  #     it 'renders a JSON response with the v1_financial_transaction' do
  #       financial_transaction = V1::FinancialTransaction.create! valid

  #       put :update, params: {
  #         id: financial_transaction.to_param,
  #         v1_financial_transaction: valid
  #       }

  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to eq('application/json')
  #     end
  #   end

  #   context 'with invalid params' do
  #     it 'renders a JSON response with errors' do
  #       financial_transaction = V1::FinancialTransaction.create! valid

  #       put :update, params: {
  #         id: financial_transaction.to_param,
  #         v1_financial_transaction: invalid
  #       }
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to eq('application/json')
  #     end
  #   end
  # end

  # describe 'DELETE #destroy' do
  #   it 'destroys the requested v1_financial_transaction' do
  #     financial_transaction = V1::FinancialTransaction.create! valid
  #     expect {
  #       delete :destroy, params: {id: financial_transaction.to_param}
  #     }.to change(V1::FinancialTransaction, :count).by(-1)
  #   end
  # end

  describe 'private method fin_trans_job' do
    let(:valid) do
      params = FactoryGirl.build(
        :financial_transaction
      ).attributes
      params[:recurrence] = FactoryGirl.attributes_for(:recurrence)
      return params
    end

    it 'is expected to enqueue a job to generate reccurences' do
      post :create, params: valid

      fin_trans = assigns(:fin_transaction)
      args = [fin_trans.class.to_s, fin_trans.id.to_s]

      expect { subject.send(:fin_trans_job, fin_trans) }
        .to have_enqueued_job(RecurrentFinancialTransactionJob)
        .with(*args)
        .on_queue('default')
    end
  end
end
