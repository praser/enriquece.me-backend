# frozen_string_literal: true

# Update recurrent financial transanctions recursevely
class UpdateRecurrencesJob < ApplicationJob
  queue_as :default

  def perform(obj_class, obj_id, modifier, days_amount)
    record = find_transaction(obj_class, obj_id)
    recurrences = find_recurrences(record, modifier)

    recurrences.each do |transaction|
      transaction.description = record.description
      transaction.price = record.price
      transaction.date = transaction.date + days_amount.days
      transaction.note = record.note
      transaction.account = record.account
      transaction.category = record.category
      transaction.subcategory = record.subcategory

      transaction.save
    end
  end

  private

  def find_transaction(obj_class, obj_id)
    obj_class.constantize.find(obj_id)
  end

  def find_recurrences(transaction, modifier)
    transactions = transaction.recurrence.transactions
    case modifier.downcase.to_sym
    when :all
      transactions.reject { |item| item == transaction }
    when :forward
      transactions.select { |item| item.date > transaction.date }
    end
  end
end
