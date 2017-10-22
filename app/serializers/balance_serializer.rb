# frozen_string_literal: true

# Balance serializer
class BalanceSerializer < ActiveModel::Serializer
  type :balance
  attributes :previous_balance, :period_balance, :daily_balance
end
