# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do
  it { is_expected.to respond_to :name }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).with_maximum(100) }

  it { is_expected.to respond_to :description }
  it { is_expected.to validate_length_of(:description).with_maximum(500) }

  it { is_expected.to respond_to :initial_balance }
  it { is_expected.to validate_presence_of :initial_balance }
  it { is_expected.to validate_numericality_of :initial_balance }

  it { is_expected.to belong_to(:initial_transaction) }

  it { is_expected.to belong_to(:bank) }
  it { is_expected.to validate_presence_of :bank_id }

  it { is_expected.to belong_to(:account_type) }
  it { is_expected.to validate_presence_of :account_type_id }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of :user_id }

  it 'triggers create_initial_transaction after create' do
    account = FactoryGirl.build(:account)
    expect(account).to receive(:create_initial_transaction)
    account.save
  end

  it 'triggers update_initial_transaction after update' do
    account = FactoryGirl.create(:account)
    expect(account).to receive(:update_initial_transaction)
    account.update(initial_balance: Random.new.rand(100))
  end

  it 'triggers delete_initial_transaction before destroy' do
    account = FactoryGirl.create(:account)
    expect(account).to receive(:delete_initial_transaction)
    account.destroy
  end

  context 'initial transaction' do
    let(:account) { FactoryGirl.create(:account) }

    it 'description is Initial Transaction' do
      description = account.initial_transaction.description
      expect(description).to eq('Initial Balance')
    end

    it 'is paid' do
      expect(account.initial_transaction.paid).to be_truthy
    end

    it 'date is 1900-01-01' do
      expect(account.initial_transaction.date).to eq(
        Time.zone.strptime('1900-01-01 Brasília', '%Y-%m-%d %Z')
      )
    end

    it 'belongs this account' do
      expect(account.initial_transaction.account_id).to eq(account.id)
    end

    it 'belongs to same user' do
      expect(account.initial_transaction.user_id).to eq(account.user_id)
    end

    it 'has a price' do
      expect(account.initial_transaction.price).to_not be_nil
    end

    it 'has no category' do
      expect(account.initial_transaction.category).to be_nil
    end
  end
end
