# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateRecurrencesJob, type: :job do
  include ActiveJob::TestHelper

  subject(:job) { described_class.perform_now(*args) }

  let(:transaction) do
    FactoryGirl.create(
      :transaction,
      recurrence: FactoryGirl.create(:recurrence)
    )
  end

  let(:args) do
    [
      transaction.class.to_s,
      transaction.id.to_s
    ]
  end

  it 'creates n financial transactions' do
    registers = transaction.recurrence.repeat - 1
    expect { job }.to change { Transaction.all.count }.by(registers)
  end

  it 'creates n transfers' do
    transaction = FactoryGirl.create(
      :transaction,
      destination_account_id: FactoryGirl.create(:account).id.to_s,
      recurrence: FactoryGirl.create(:recurrence)
    )

    args[1] = transaction.id.to_s

    registers = transaction.recurrence.repeat - 1
    expect { job }.to change { Transaction.all.count }.by(registers * 2)
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
