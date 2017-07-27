# frozen_string_literal: true

# Deletes recurrences assyncronously
class DeleteRecurrencesJob < ApplicationJob
  queue_as :default

  def perform(obj_class, obj_id, modifier, date = nil)
    get_transactions(obj_class, obj_id, modifier, date).each(&:delete)
  end

  private

  def find_recurrence(obj_class, obj_id)
    obj_class.constantize.find(obj_id)
  end

  def get_transactions(obj_class, obj_id, modifier, date)
    transactions = find_recurrence(obj_class, obj_id).transactions
    date = Date.parse(date) unless date.nil?

    case modifier.downcase.to_sym
    when :all then transactions
    when :forward then transactions.select { |item| item.date > date }
    end
  end
end
