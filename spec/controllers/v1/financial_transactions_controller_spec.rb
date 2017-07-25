# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::FinancialTransactionsController, type: :controller do
  ActiveJob::Base.queue_adapter = :test

  before(:each) do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    before(:each) do
      10.times do
        FactoryGirl.create(:financial_transaction, user: user)
        FactoryGirl.create(:financial_transaction)
      end
    end

    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end

    it 'lists transactions in the month when no param is provided' do
      get :index
      fin_trans = FinancialTransaction.where(
        date: {
          :$gte => Date.today.at_beginning_of_month,
          :$lte => Date.today.at_end_of_month
        },
        user_id: {
          :$eq => user.id.to_s
        }
      )

      expect(assigns(:fin_trans)).to eq(fin_trans)
    end

    it 'lists transactions since a date when start param is provided' do
      start_date = Faker::Date.backward(30)
      get :index, params: { start: start_date }

      fin_trans = FinancialTransaction.where(
        date: {
          :$gte => start_date,
          :$lte => Date.today.at_end_of_month
        },
        user_id: {
          :$eq => user.id.to_s
        }
      )

      expect(assigns(:fin_trans)).to eq fin_trans
    end

    it 'lists transactions interval when start and end params are provided' do
      start_date = Faker::Date.backward(30)
      end_date = Faker::Date.forward(30)

      get :index, params: { start: start_date, end: end_date }

      fin_trans = FinancialTransaction.where(
        date: {
          :$gte => start_date,
          :$lte => end_date
        },
        user_id: {
          :$eq => user.id.to_s
        }
      )

      expect(assigns(:fin_trans)).to eq fin_trans
    end
  end

  describe 'GET #show' do
    let(:fin_trans) { FactoryGirl.create(:financial_transaction, user: user) }

    it 'returns a success response' do
      get :show, params: { id: fin_trans.id.to_s }
      expect(response).to be_success
    end

    context 'request anothers user financial transaction' do
      let(:anothers_fin_trans) do
        FactoryGirl.create(
          :financial_transaction,
          user: FactoryGirl.create(:user)
        )
      end

      it 'does not show ' do
        get :show, params: { id: anothers_fin_trans.id.to_s }
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

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

      it 'assigns a newly financial transaction as @fin_trans' do
        post :create, params: valid
        expect(assigns(:fin_trans)).to be_a(FinancialTransaction)
        expect(assigns(:fin_trans)).to be_persisted
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
        expect(assigns(:fin_trans).user).to eq(user)
      end

      it 'is expected to call create_recurrences when recurrence exists' do
        expect(subject).to receive(:create_recurrences)
        post :create, params: valid
      end

      it 'is not expected to call create_recurrences if no recurrence exists' do
        expect(subject).to_not receive(:create_recurrences)
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

  describe 'PUT #update' do
    let(:fin_trans) { FactoryGirl.create(:financial_transaction, user: user) }

    context 'with valid params' do
      let(:update_params) do
        FactoryGirl.attributes_for(
          :financial_transaction,
          id: fin_trans.id,
          recurrence: :foward
        )
      end

      it 'updates the requested financial transaction' do
        put :update, params: update_params
        fin_trans.reload
        expect(fin_trans.description).to eq(fin_trans.description)
      end

      it 'renders a JSON response with the financial transaction' do
        put :update, params: update_params

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end

      it 'calls update_recurrences when recurrence param is provided' do
        expect(subject).to receive(:update_recurrences)
        put :update, params: update_params
      end

      it 'doesnt call update_recurrences if recurrence param is not provided' do
        expect(subject).to_not receive(:update_recurrences)
        put :update, params: update_params.except(:recurrence)
      end
    end

    context 'with invalid params' do
      let(:update_params) do
        FactoryGirl.attributes_for(
          :financial_transaction,
          :invalid,
          id: fin_trans.id
        )
      end

      it 'renders a JSON response with errors' do
        put :update, params: update_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'anothers user financial transaction' do
      let(:fin_trans) do
        FactoryGirl.create(
          :financial_transaction,
          user: FactoryGirl.create(:user)
        )
      end

      let(:update_params) do
        FactoryGirl.attributes_for(
          :financial_transaction,
          id: fin_trans.id
        )
      end

      it 'renders a JSON response with errors' do
        put :update, params: update_params
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:fin_trans) { FactoryGirl.create(:financial_transaction, user: user) }

    it 'destroys the requested financialtransaction' do
      expect do
        delete :destroy, params: { id: fin_trans.id.to_s }
      end.to change(FinancialTransaction, :count).by(-1)
    end

    context 'anothes user financial transaction' do
      let!(:anothers_fin_trans) do
        FactoryGirl.create(
          :financial_transaction,
          user: FactoryGirl.create(:user)
        )
      end

      it 'does not destroy the requested financial transaction' do
        expect do
          delete :destroy, params: { id: anothers_fin_trans.id.to_s }
        end.to_not change(FinancialTransaction, :count)
      end
    end
  end

  describe 'private method create_recurrences' do
    let(:valid) do
      params = FactoryGirl.build(
        :financial_transaction
      ).attributes
      params[:recurrence] = FactoryGirl.attributes_for(:recurrence)
      return params
    end

    it 'is expected to enqueue a job to generate reccurences' do
      post :create, params: valid

      fin_trans = assigns(:fin_trans)
      args = [fin_trans.class.to_s, fin_trans.id.to_s]

      expect { subject.send(:create_recurrences, fin_trans) }
        .to have_enqueued_job(CreateRecurrencesJob)
        .with(*args)
        .on_queue('default')
    end
  end

  describe 'private method update_recurrences' do
    let(:fin_trans) { FactoryGirl.create(:financial_transaction) }
    let(:update_params) do
      FactoryGirl.attributes_for(
        :financial_transaction,
        id: fin_trans.id,
        recurrence: 'foward'
      )
    end

    it 'is expected to enqueue a job to update reccurences' do
      put :update, params: update_params

      args = [
        fin_trans.class.to_s,
        fin_trans.id.to_s,
        update_params[:recurrence],
        4
      ]

      expect { subject.send(:update_recurrences, fin_trans, *args[2..3]) }
        .to have_enqueued_job(UpdateRecurrencesJob)
        .with(*args)
        .on_queue('default')
    end
  end
end
