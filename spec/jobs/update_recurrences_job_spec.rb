# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateRecurrencesJob, type: :job do
  include ActiveJob::TestHelper

  before(:each) do
    f = FactoryGirl.create(
      :financial_transaction,
      recurrence: FactoryGirl.create(:recurrence)
    )
    CreateRecurrencesJob.perform_now(f.class.to_s, f.id.to_s)
  end

  # subject(:job) { described_class.perform_now(*args) }

  let(:fin_trans) { Recurrence.last.financial_transactions.sample }

  context 'updates all recurrences' do
    let(:args) { [fin_trans.class.to_s, fin_trans.id.to_s, 'all', 3] }

    it 'changes all financial transactions' do
      described_class.perform_now(*args)

      expect(
        FinancialTransaction
        .where(updated_at: { :$gt => fin_trans.created_at })
        .and(recurrence_id: fin_trans.recurrence_id)
      ).to eq(
        FinancialTransaction
        .where(recurrence_id: fin_trans.recurrence_id)
        .reject { |item| item == fin_trans }
      )
    end
  end

  context 'updates forward recurrences' do
    let(:args) { [fin_trans.class.to_s, fin_trans.id.to_s, 'forward', 3] }

    it 'changes only transactions after given one' do
      described_class.perform_now(*args)
      expect(
        FinancialTransaction
        .where(updated_at: { :$gt => fin_trans.created_at })
        .and(recurrence_id: fin_trans.recurrence_id)
        .to_a
      ).to eq(
        FinancialTransaction
        .where(date: { :$gt => fin_trans.date })
        .and(recurrence_id: fin_trans.recurrence_id)
        .to_a
      )
    end
  end
end
