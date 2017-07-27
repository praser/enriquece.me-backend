# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeleteRecurrencesJob, type: :job do
  include ActiveJob::TestHelper

  before(:each) do
    f = FactoryGirl.create(
      :transaction,
      recurrence: FactoryGirl.create(:recurrence)
    )
    CreateRecurrencesJob.perform_now(f.class.to_s, f.id.to_s)
  end

  let(:transaction) { Recurrence.last.transactions.sample }
  let(:recurrences) do
    transaction.recurrence.transactions.reject do |item|
      item == transaction
    end
  end
  let(:recurrences_after) do
    recurrences.select { |item| item.date > transaction.date }
  end

  subject(:job) { described_class.perform_now(*args) }

  context 'deletes all recurrences' do
    let(:args) do
      [
        transaction.recurrence.class.to_s,
        transaction.recurrence.id.to_s,
        'all'
      ]
    end

    it 'removes all transactions' do
      transaction.delete
      expect { job }.to change { Transaction.all.count }.by(-recurrences.count)
    end
  end

  context 'deletes forward recurrences' do
    let(:args) do
      [
        transaction.recurrence.class.to_s,
        transaction.recurrence.id.to_s,
        'forward',
        transaction.date.to_s
      ]
    end

    it 'removes transactions after the given one' do
      transaction.delete
      expect { job }.to change { Transaction.all.count }.by(
        -recurrences_after.count
      )
    end
  end
end
