# frozen_string_literal: true

# Create recurrent transanctions recursevely
class CreateRecurrencesJob < ApplicationJob
  queue_as :default

  def perform(obj_class, obj_id)
    recurrence_attr = transaction_recurrence_attr(obj_class, obj_id)
    dates(*recurrence_attr).each do |date|
      clone_transaction(transaction(obj_class, obj_id), date)
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

  def clone_transaction(transaction, date)
    Transaction.create(
      description: transaction.description,
      price: transaction.price,
      date: date,
      note: transaction.note,
      account: transaction.account,
      category: transaction.category,
      subcategory: transaction.subcategory,
      recurrence: transaction.recurrence,
      user: transaction.user
    )
  end

  def transaction_recurrence_attr(obj_class, obj_id)
    rec = transaction(obj_class, obj_id).recurrence

    [
      rec.every.to_sym,
      rec.on.numeric? ? rec.on : rec.on.to_sym,
      rec.interval.numeric? ? rec.interval : rec.interval.to_sym,
      rec.repeat
    ]
  end

  def transaction(obj_class, obj_id)
    obj_class.constantize.find(obj_id)
  end
end
