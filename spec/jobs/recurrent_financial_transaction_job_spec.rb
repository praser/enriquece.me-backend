# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecurrentFinancialTransactionJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_now(*args) }

  let(:financial_transaction) do
    FactoryGirl.create(
      :financial_transaction,
      recurrence: FactoryGirl.create(:recurrence)
    )
  end

  let(:args) do
    [
      financial_transaction.class.to_s,
      financial_transaction.id.to_s
    ]
  end

  it 'creates n financial transactions' do
    registers = financial_transaction.recurrence.repeat - 1
    expect { job }.to change { FinancialTransaction.all.count }.by(registers)
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
