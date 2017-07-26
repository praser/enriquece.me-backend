# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateRecurrencesJob, type: :job do
  include ActiveJob::TestHelper

  before(:each) do
    f = FactoryGirl.create(
      :transaction,
      recurrence: FactoryGirl.create(:recurrence)
    )
    CreateRecurrencesJob.perform_now(f.class.to_s, f.id.to_s)
  end

  let(:transaction) { Recurrence.last.transactions.sample }

  context 'updates all recurrences' do
    let(:args) { [transaction.class.to_s, transaction.id.to_s, 'all', 3] }

    it 'changes all transactions' do
      described_class.perform_now(*args)

      expect(
        Transaction
        .where(updated_at: { :$gt => transaction.created_at })
        .and(recurrence_id: transaction.recurrence_id)
      ).to eq(
        Transaction
        .where(recurrence_id: transaction.recurrence_id)
        .reject { |item| item == transaction }
      )
    end
  end

  context 'updates forward recurrences' do
    let(:args) { [transaction.class.to_s, transaction.id.to_s, 'forward', 3] }

    it 'changes only transactions after given one' do
      described_class.perform_now(*args)
      expect(
        Transaction
        .where(updated_at: { :$gt => transaction.created_at })
        .and(recurrence_id: transaction.recurrence_id)
        .to_a
      ).to eq(
        Transaction
        .where(date: { :$gt => transaction.date })
        .and(recurrence_id: transaction.recurrence_id)
        .to_a
      )
    end
  end
end
