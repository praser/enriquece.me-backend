# frozen_string_literal: true

require 'rails_helper'

RSpec.describe V1::TransactionsController, type: :controller do
  ActiveJob::Base.queue_adapter = :test

  before(:each) do
    allow(controller).to receive(:authenticate_request).and_return(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  let(:user) { FactoryGirl.create(:user) }

  describe 'GET #index' do
    before(:each) do
      10.times do
        FactoryGirl.create(:transaction, user: user)
        FactoryGirl.create(:transaction)
      end
    end

    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end

    it 'lists transactions in the month when no param is provided' do
      get :index
      transaction = Transaction.where(
        date: {
          :$gte => Time.current.at_beginning_of_month,
          :$lte => Time.current.at_end_of_month
        },
        user_id: {
          :$eq => user.id.to_s
        }
      )

      expect(assigns(:transactions)).to eq(transaction)
    end

    it 'lists transactions since a date when start param is provided' do
      start_date = Faker::Date.backward(30)
      get :index, params: { start: start_date }

      transaction = Transaction.where(
        date: {
          :$gte => start_date,
          :$lte => Time.current.at_end_of_month
        },
        user_id: {
          :$eq => user.id.to_s
        }
      )

      expect(assigns(:transactions)).to eq transaction
    end

    it 'lists transactions interval when start and end params are provided' do
      start_date = Faker::Date.backward(30)
      end_date = Faker::Date.forward(30)

      get :index, params: { start: start_date, end: end_date }

      transaction = Transaction.where(
        date: {
          :$gte => start_date,
          :$lte => end_date
        },
        user_id: {
          :$eq => user.id.to_s
        }
      )

      expect(assigns(:transactions)).to eq transaction
    end
  end

  describe 'GET #show' do
    let(:transaction) { FactoryGirl.create(:transaction, user: user) }

    it 'returns a success response' do
      get :show, params: { id: transaction.id.to_s }
      expect(response).to be_success
    end

    context 'request anothers user financial transaction' do
      let(:anothers_transaction) do
        FactoryGirl.create(
          :transaction,
          user: FactoryGirl.create(:user)
        )
      end

      it 'does not show ' do
        get :show, params: { id: anothers_transaction.id.to_s }
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'POST #create' do
    let(:valid) do
      params = FactoryGirl.build(
        :transaction
      ).attributes
      params[:recurrence] = FactoryGirl.attributes_for(:recurrence)

      return params
    end

    let(:invalid) do
      FactoryGirl.attributes_for(:transaction, :invalid)
    end

    context 'with valid params' do
      it 'creates a new Transaction' do
        valid
        expect do
          post :create, params: valid
        end.to change(Transaction, :count).by(1)
      end

      it 'creates a new Transfer' do
        valid[:destination_account_id] = FactoryGirl.create(:account).id.to_s
        expect do
          post :create, params: valid
        end.to change(Transaction, :count).by(2)
        expect(assigns(:transaction).transfer?).to be_truthy
      end

      it 'assigns a newly financial transaction as @fin_trans' do
        post :create, params: valid
        expect(assigns(:transaction)).to be_a(Transaction)
        expect(assigns(:transaction)).to be_persisted
      end

      it 'renders a JSON response with the new financial_transaction' do
        post :create, params: valid
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to(
          eq(v1_transaction_path(Transaction.last))
        )
      end

      it 'creates a new financial transaction belonging to current user' do
        post :create, params: valid
        expect(assigns(:transaction).user).to eq(user)
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
    let(:transaction) { FactoryGirl.create(:transaction, user: user) }

    context 'with valid params' do
      let(:update_params) do
        FactoryGirl.attributes_for(
          :transaction,
          id: transaction.id,
          recurrence: :foward
        )
      end

      it 'updates the requested financial transaction' do
        expect do
          put :update, params: update_params
          transaction.reload
        end.to change(transaction, :attributes)
      end

      it 'updates the requested transfer' do
        transfer = FactoryGirl.create(
          :transaction,
          destination_account_id: FactoryGirl.create(:account).id.to_s
        )

        update_params = FactoryGirl.attributes_for(
          :transaction,
          id: transfer.id,
          recurrence: :foward
        )

        expect do
          put :update, params: update_params
          transfer.transfer_destination.reload
        end.to change(transfer.transfer_destination, :attributes)
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
          :transaction,
          :invalid,
          id: transaction.id
        )
      end

      it 'renders a JSON response with errors' do
        put :update, params: update_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'anothers user financial transaction' do
      let(:anothers_transaction) do
        FactoryGirl.create(:transaction)
      end

      it 'renders a JSON response with errors' do
        put :update, params: { id: anothers_transaction.id.to_s }
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:transaction) { FactoryGirl.create(:transaction, user: user) }

    it 'destroys the requested Transaction' do
      expect do
        delete :destroy, params: { id: transaction.id.to_s }
      end.to change(Transaction, :count).by(-1)
    end

    it 'destroys the requested Transfer' do
      transfer = FactoryGirl.create(
        :transaction,
        destination_account_id: FactoryGirl.create(:account).id.to_s,
        user: user
      )

      expect do
        delete :destroy, params: { id: transfer.id.to_s }
      end.to change(Transaction, :count).by(-2)
    end

    it 'calls delete_recurrences when recurrence param all is provided' do
      expect(subject).to receive(:delete_recurrences)
      delete :destroy, params: { id: transaction.id, recurrence: 'all' }
    end

    it 'calls delete_recurrences when recurrence param forward is provided' do
      expect(subject).to receive(:delete_recurrences)
      delete :destroy, params: {
        id: transaction.id,
        recurrence: 'forward'
      }
    end

    it 'doesnt call delete_recurrences if recurrence param is not provided' do
      expect(subject).to_not receive(:delete_recurrences)
      put :update, params: { id: transaction.id }
    end

    context 'anothes user financial transaction' do
      let!(:anothers_transaction) do
        FactoryGirl.create(
          :transaction,
          user: FactoryGirl.create(:user)
        )
      end

      it 'does not destroy the requested financial transaction' do
        expect do
          delete :destroy, params: { id: anothers_transaction.id.to_s }
        end.to_not change(Transaction, :count)
      end
    end
  end

  describe 'private method create_recurrences' do
    let(:valid) do
      params = FactoryGirl.build(
        :transaction
      ).attributes
      params[:recurrence] = FactoryGirl.attributes_for(:recurrence)
      return params
    end

    it 'is expected to enqueue a job to generate reccurences' do
      post :create, params: valid

      transaction = assigns(:transaction)
      args = [transaction.class.to_s, transaction.id.to_s]

      expect { subject.send(:create_recurrences, transaction) }
        .to have_enqueued_job(CreateRecurrencesJob)
        .with(*args)
        .on_queue('default')
    end
  end

  describe 'private method update_recurrences' do
    let(:transaction) { FactoryGirl.create(:transaction) }
    let(:update_params) do
      FactoryGirl.attributes_for(
        :transaction,
        id: transaction.id,
        recurrence: 'foward'
      )
    end

    it 'is expected to enqueue a job to update reccurences' do
      put :update, params: update_params

      args = [
        transaction.class.to_s,
        transaction.id.to_s,
        update_params[:recurrence],
        4
      ]

      expect { subject.send(:update_recurrences, transaction, *args[2..3]) }
        .to have_enqueued_job(UpdateRecurrencesJob)
        .with(*args)
        .on_queue('default')
    end
  end

  describe 'private method delete_recurrences' do
    let(:transaction) do
      FactoryGirl.create(
        :transaction,
        recurrence: FactoryGirl.create(:recurrence)
      )
    end

    it 'is expected to enqueue a job to update reccurences' do
      delete :destroy, params: { id: transaction.id }

      args = [
        transaction.recurrence.class.to_s,
        transaction.recurrence.id.to_s,
        'forward',
        transaction.date.to_s
      ]

      expect do
        subject.send(:delete_recurrences, transaction.recurrence, *args[2..3])
      end
        .to have_enqueued_job(DeleteRecurrencesJob)
        .with(*args)
        .on_queue('default')
    end
  end
end
