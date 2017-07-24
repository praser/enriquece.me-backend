# frozen_string_literal: true

# Create recurrent financial transanctions recursevely
class CreateRecurrencesJob < ApplicationJob
  queue_as :default

  def perform(obj_class, obj_id)
    reucurrence_attributes = fin_trans_recurrence_attributes(obj_class, obj_id)
    dates(*reucurrence_attributes).each do |date|
      clone_financial_transaction(fin_trans(obj_class, obj_id), date)
    end
  end

  private

  def dates(every, on, interval, repeat)
    dates = SimplesIdeias::Recurrence.new(
      every: every,
      on: on,
      interval: interval,
      repeat: repeat
    ).events

    dates.shift
    dates
  end

  def clone_financial_transaction(fin_trans, date)
    FinancialTransaction.create(
      description: fin_trans.description,
      price: fin_trans.price,
      date: date,
      note: fin_trans.note,
      account: fin_trans.account,
      category: fin_trans.category,
      subcategory: fin_trans.subcategory,
      recurrence: fin_trans.recurrence,
      user: fin_trans.user
    )
  end

  def fin_trans_recurrence_attributes(obj_class, obj_id)
    rec = fin_trans(obj_class, obj_id).recurrence

    [
      rec.every.to_sym,
      rec.on.numeric? ? rec.on : rec.on.to_sym,
      rec.interval.numeric? ? rec.interval : rec.interval.to_sym,
      rec.repeat
    ]
  end

  def fin_trans(obj_class, obj_id)
    obj_class.constantize.find(obj_id)
  end
end
